# frozen_string_literal: true

require "spec_helper"

RSpec.describe "Kobana::VERSION" do
  it "has a version number" do
    expect(Kobana::VERSION).not_to be nil
  end
end
