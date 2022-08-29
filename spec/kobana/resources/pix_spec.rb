# frozen_string_literal: true

require "spec_helper"

RSpec.describe Kobana::PixResource do
  it "should create a pix" do
    # Given
    payload = { pix_account_id: 246,
                amount: 120.99,
                expire_at: "2023-12-02T10:03:56-03:00" }
    Kobana.setup do |c|
      c.api_key = "fake"
      c.stubs = stub_post(
        url: "#{c.base_url}/charge/pix",
        body: payload,
        response: fake_response(fixture: "resources/pix/create/ok", status: 201)
      )
    end

    # When
    pix = Kobana.pix.create(**payload)

    # Then
    expect(pix.class).to be(Kobana::PixObject)
    expect(pix.id).to be(232)
    expect(pix.status).to eq("opened")
  end

  it "should find a pix" do
    # Given
    pix_id = 233
    Kobana.setup do |c|
      c.api_key = "fake"
      c.stubs = stub_get(
        url: "#{c.base_url}/charge/pix/#{pix_id}",
        response: fake_response(fixture: "resources/pix/find/ok", status: 201)
      )
    end

    # When
    pix = Kobana.pix.find(pix_id)

    # Then
    expect(pix.class).to be(Kobana::PixObject)
    expect(pix.id).to be(233)
    expect(pix.status).to eq("opened")
  end

  it "should raise Kobana::Error when api key is invalid" do
    # Given
    payload = { pix_account_id: 246,
                amount: 120.99,
                expire_at: "2023-12-02T10:03:56-03:00" }
    Kobana.setup do |c|
      c.api_key = "fake"
      c.stubs = stub_post(
        url: "#{c.base_url}/charge/pix",
        response: fake_response(fixture: "resources/pix/invalid_token", status: 401),
        body: payload
      )
    end

    expect { Kobana.pix.create(**payload) }.to raise_error do |error|
      expect(error).to be_a(Kobana::Error)
      expect(error.status).to be(401)
      expect(error.error_message).to eq("O Token de API é diferente para cada Servidor/URL, mais em https://developers.kobana.com.br/reference/token-de-acesso")
    end
  end

  it "should raise Kobana::Error when params are invalid" do
    # Given
    Kobana.setup do |c|
      c.api_key = "fake"
      c.stubs = stub_post(
        url: "#{c.base_url}/charge/pix",
        response: fake_response(fixture: "resources/pix/invalid_params", status: 422),
        body: {}
      )
    end

    expect { Kobana.pix.create }.to raise_error do |error|
      expect(error).to be_a(Kobana::Error)
      expect(error.status).to be(422)
      expect(error.error_message).to eq("Quantia não pode ficar em branco")
    end
  end

  it "should raise Kobana::Error when pix was not found" do
    # Given
    pix_id = 233
    Kobana.setup do |c|
      c.api_key = "fake"
      c.stubs = stub_get(
        url: "#{c.base_url}/charge/pix/#{pix_id}",
        response: fake_response(fixture: "resources/pix/find/not_found", status: 404)
      )
    end

    expect { Kobana.pix.find(pix_id) }.to raise_error do |error|
      expect(error).to be_a(Kobana::Error)
      expect(error.status).to be(404)
      expect(error.error_message).to eq("Este registro não existe, ou foi deletado.")
    end
  end
end
