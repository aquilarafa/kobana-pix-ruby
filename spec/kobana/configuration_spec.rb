# frozen_string_literal: true

require "spec_helper"
require "faraday"

RSpec.describe Kobana::Configuration do
  describe "defaults" do
    it "initializes configuration with defaults" do
      config = Kobana.setup

      expect(config).to be(Kobana.configuration)
      expect(config.environment).to be(:sandbox)
      expect(config.base_url).to eq("https://api-sandbox.kobana.com.br/v2")
      expect(config.api_key).to be_nil
      expect(config.client).not_to be_nil
    end
  end

  describe "initializes with stubs adapter" do
    it do
      config = Kobana.setup
      config.stubs = Faraday::Adapter::Test::Stubs.new

      expect(config.stubs).not_to be_nil
    end
  end

  describe "#api_key=" do
    it do
      config = Kobana.setup

      config.api_key = "api_key"

      expect(config.api_key).to eq("api_key")
    end
  end
end
