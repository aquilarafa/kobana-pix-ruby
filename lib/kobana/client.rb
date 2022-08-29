# frozen_string_literal: true

require "faraday"
require "faraday_middleware"

module Kobana
  class Client
    def initialize(adapter: :net_http, configuration: Configuration.new, stubs: nil)
      @configuration = configuration
      @adapter = adapter
      @stubs = stubs
    end

    def connection
      base_url = @configuration.base_url
      api_key  = @configuration.api_key

      @connection ||= Faraday.new(base_url) do |conn|
        conn.request :json
        conn.request :authorization, :Bearer, api_key
        # conn.response :logger
        conn.use Kobana::Middleware::RaiseError
        conn.response :json, content_type: "application/json"
        conn.adapter @adapter if @stubs.nil?
        conn.adapter :test, @stubs if @stubs
      end
    end

    def inspect
      "#<Kobana::Client>"
    end
  end
end
