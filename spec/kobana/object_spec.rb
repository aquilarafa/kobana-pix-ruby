# frozen_string_literal: true

require "spec_helper"

RSpec.describe Kobana::Object do
  it "creates a object from hash" do
    expect(Kobana::Object.new(foo: "bar").foo).to eq("bar")
  end

  it "creates a object from nested hash" do
    obj = Kobana::Object.new(foo: { bar: { luz: "foobarluz" } })
    expect(obj.foo.bar.luz).to eq("foobarluz")
  end

  it "creates a object with number" do
    obj = Kobana::Object.new(foo: { bar: 2 })
    expect(obj.foo.bar).to be(2)
  end
end
