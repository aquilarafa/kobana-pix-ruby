# frozen_string_literal: true

require "kobana"
require "webmock/rspec"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  def fake_response(fixture: nil, status: 200, headers: { "Content-Type" => "application/json" })
    [status, headers, File.read("spec/fixtures/#{fixture}.json")]
  end

  def stub_post(url:, response:, body: {})
    Faraday::Adapter::Test::Stubs.new do |stub|
      stub.post(url, body.to_json) { |_env| response }
    end
  end

  def stub_get(url:, response:)
    Faraday::Adapter::Test::Stubs.new do |stub|
      stub.get(url) { |_env| response }
    end
  end
end
