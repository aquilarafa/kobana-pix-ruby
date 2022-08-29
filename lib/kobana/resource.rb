# frozen_string_literal: true

module Kobana
  class Resource
    def initialize(client)
      @client = client
    end

    def get_request(url, params: {}, headers: {})
      @client.connection.get(url, params, headers)
    end

    def post_request(url, params: {}, headers: {})
      @client.connection.post(url, params, headers)
    end
  end
end
