# frozen_string_literal: true

module Kobana
  class PixResource < Resource
    def create(**attributes)
      PixObject.new post_request("charge/pix", params: attributes).body["data"]
    end

    def find(id)
      PixObject.new get_request("charge/pix/#{id}").body["data"]
    end
  end
end
