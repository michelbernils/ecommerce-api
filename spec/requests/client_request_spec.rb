# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Test clients requests', type: :request do
  context 'get /clients index' do
    it '200 OK' do
      headers = { 'Content-Type' => 'application/json' }
      get '/clients', params: {}, headers: headers

      expect(response).to have_http_status(200)
    end
  end

  context 'get /clients/:id' do
    it '200' do
      client = Client.create!(name: 'michel', email: 'xpto', password_digest: '1234789')
      headers = { 'Content-Type' => 'application/json' }
      get "/clients/#{client.id}", params: {}, headers: headers

      expect(response).to have_http_status(200)
      expect(response.parsed_body['client']['name']).to eq('michel')
      expect(response.parsed_body['client']['email']).to eq('xpto')
      expect(response.parsed_body['client']['password_digest']).to eq('1234789')
    end
  end

  context 'post /clients/' do
    it '200' do
      client = Client.create!(id: 2, name: 'michel', email: 'xpto', password_digest: '1234789')
      headers = { 'Content-Type' => 'application/json' }
      get "/clients/#{client.id}", params: {}, headers: headers

      expect(response).to have_http_status(200)
      expect(response.parsed_body['client']['name']).to eq('michel')
      expect(response.parsed_body['client']['email']).to eq('xpto')
      expect(response.parsed_body['client']['password_digest']).to eq('1234789')
    end

    it '201' do
      # client_post = Client.new(id: 2, name: 'michel', email: 'xpto113456', password: '1234567')
      client_post = { "client": { "name": 'michel', 'email': 'xpto113456', 'password': 'xpto113456' } }

      headers = { 'Content-Type': 'application/json' }
      post '/clients', params: client_post.to_json, headers: headers

      expect(response).to have_http_status(201)
      expect(client_post[:client][:name]).to eq('michel')
      expect(client_post[:client][:email]).to eq('xpto113456')
      expect(client_post[:client][:password]).to eq('xpto113456')
    end

    it '422' do
      client = Client.create!(id: 1, name: 'michel', email: 'xpto10', password: '1234567')
      headers = { 'Content-Type': 'application/json' }
      post '/clients', params: client.to_json, headers: headers

      expect(response).to have_http_status(422)
    end

    it 'Parameters Missing' do
      headers = { 'Content-Type': 'application/json' }
      expect { post '/clients/', params: {}, headers: headers }.to raise_error(ActionController::ParameterMissing)
    end
  end

  context 'put /clients/:id' do
    it '201' do
      headers = { 'Content-Type': 'application/json' }
      client = Client.create!(id: 1, name: 'michel', email: 'xpto', password_digest: '1234567')
      client_update = { 'name': 'john', 'email': 'john.doe@gmail.com', 'password_digest': '123456' }
      put "/clients/#{client.id}", params: client_update.to_json, headers: headers

      expect(response).to have_http_status(200)
      expect(client.name).to eq('michel')
      expect(client.email).to eq('xpto')
      expect(client_update[:name]).to eq('john')
      expect(client_update[:email]).to eq('john.doe@gmail.com')
      expect(client_update[:password_digest]).to eq('123456')
    end

    it '204' do
      headers = { 'Content-Type': 'application/json' }
      client_update = { 'name': 'john', 'email': 'john.doe@gmail.com', 'password_digest': '123456' }
      put '/clients/1', params: client_update.to_json, headers: headers

      expect(response).to have_http_status(204)
    end
  end

  context 'delete /clients/:id' do
    it '200' do
      headers = { 'Content-Type': 'application/json' }
      client = Client.create!(id: 1, name: 'michel', email: 'xpto', password_digest: '1234678')
      delete "/clients/#{client.id}", params: {}, headers: headers

      expect(response).to have_http_status(200)
    end

    it '204' do
      headers = { 'Content-Type': 'application/json' }
      delete '/clients/1', params: {}, headers: headers

      expect(response).to have_http_status(204)
    end
  end
end
