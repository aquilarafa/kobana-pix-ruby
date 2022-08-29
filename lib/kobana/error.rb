# frozen_string_literal: true

module Kobana
  class Error < StandardError
    attr_reader :response, :body, :status, :method, :url, :error_message, :errors

    def initialize(response = nil)
      @response = response
      @body = response.response_body
      @status = response[:status].to_i
      @method = response[:method].to_s.upcase
      @url = response[:url]

      @errors = @body["errors"].to_a
      @error_message = errors.first["detail"] unless @errors.empty?

      super
    end

    def to_s
      msg = ""
      msg += "#{status} #{method} #{url}"
      msg << " (#{error_message})" unless error_message.empty?
      msg << "\n"
      msg << @errors.to_s unless @errors.empty?
      msg
    end
  end
end
