# frozen_string_literal: true

module Kobana
  class Configuration
    attr_reader :client
    attr_accessor :environment, :api_key, :stubs

    BASE_URL = {
      sandbox: "https://api-sandbox.kobana.com.br/v2",
      production: "https://api.kobana.com.br/v2"
    }.freeze

    def initialize
      @environment = :sandbox
      @api_key = nil
      @stubs = nil
    end

    def base_url
      BASE_URL[@environment]
    end

    def setup_client
      @client = Client.new(stubs: @stubs, configuration: self)
    end
  end
end
