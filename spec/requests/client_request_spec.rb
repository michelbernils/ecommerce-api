# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Test clients requests', type: :request do
  let(:headers) { { 'Content-Type' => 'application/json' } }
  let(:client) { Client.create!(name: 'michel', email: 'xpto', password_digest: '123456789') }
  let(:client_json) { { "client": { "name": 'michel', 'email': 'xpto', 'password': '123456789' } } }

  context 'get /clients index' do
    it '200 OK' do
      get('/clients', params: {}, headers:)

      expect(response).to have_http_status(200)
    end
  end

  context 'get /clients/:id' do
    it '200' do
      get("/clients/#{client.id}", params: {}, headers:)

      expect(response).to have_http_status(200)
      expect(response.parsed_body['client']['name']).to eq(client.name)
      expect(response.parsed_body['client']['email']).to eq(client.email)
      expect(response.parsed_body['client']['password_digest']).to eq(client.password_digest)
    end
  end

  context 'post /clients/' do
    it '201' do
      post('/clients', params: client_json.to_json, headers:)

      expect(response).to have_http_status(201)
      expect(response.parsed_body['client']['name']).to eq(client_json[:client][:name])
      expect(response.parsed_body['client']['email']).to eq(client_json[:client][:email])
      expect(BCrypt::Password.new(response.parsed_body['client']['password_digest'])).to eq(client_json[:client][:password])
    end

    it 'Parameters Missing' do
      expect { post '/clients/', params: {}, headers: }.to raise_error(ActionController::ParameterMissing)
    end
  end

  context 'put /clients/:id' do
    client_update = { 'name': 'john', 'email': 'john.doe@gmail.com', 'password': '123456' }

    it '201' do
      put("/clients/#{client.id}", params: client_update.to_json, headers:)

      expect(response).to have_http_status(200)
      expect(response.parsed_body['client']['name']).to eq(client_update[:name])
      expect(response.parsed_body['client']['email']).to eq(client_update[:email])
      expect(response.parsed_body['client']['password']).to eq(client_update[:password_digest])
    end

    it '204' do
      put('/clients/1', params: {}.to_json, headers:)

      expect(response).to have_http_status(204)
    end
  end

  context 'delete /clients/:id' do
    it '200' do
      delete("/clients/#{client.id}", params: {}, headers:)

      expect(response).to have_http_status(200)
    end

    it '204' do
      delete('/clients/1', params: {}, headers:)

      expect(response).to have_http_status(204)
    end
  end
end
