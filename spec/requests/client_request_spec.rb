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
      client = Client.create!(id: 1, name: 'michel', email: 'xpto')
      headers = { 'Content-Type' => 'application/json' }
      get "/clients/#{client.id}", params: {}, headers: headers

      expect(response).to have_http_status(200)
    end
  end

  context 'post /clients/' do
    it '200' do
      headers =  { 'Content-Type': 'application/json' }
      client = { 'name': 'john', 'email': 'john.doe@gmail.com' }
      post '/clients', params: client.to_json, headers: headers

      expect(response).to have_http_status(201)
      expect(client[:name]).to eq('john')
      expect(client[:email]).to eq('john.doe@gmail.com')
    end

    it 'Parameters Missing' do
      headers = { 'Content-Type': 'application/json' }
      expect { post '/clients/', params: {}, headers: headers }.to raise_error(ActionController::ParameterMissing)
    end
  end

  context 'put /clients/:id' do
    it '200' do
      headers = { 'Content-Type': 'application/json' }
      client = Client.create!(id: 1, name: 'michel', email: 'xpto')
      client_update = { 'name': 'john', 'email': 'john.doe@gmail.com' }
      put "/clients/#{client.id}", params: client_update.to_json, headers: headers

      expect(response).to have_http_status(200)
      expect(client.name).to eq('michel')
      expect(client.email).to eq('xpto')
      expect(client_update[:name]).to eq('john')
      expect(client_update[:email]).to eq('john.doe@gmail.com')
    end

    it '204' do
      headers = { 'Content-Type': 'application/json' }
      client_update = { 'name': 'john', 'email': 'john.doe@gmail.com' }
      put '/clients/1', params: client_update.to_json, headers: headers

      expect(response).to have_http_status(204)
    end
  end

  context 'delete /clients/:id' do
    it '200' do
      headers = { 'Content-Type': 'application/json' }
      client = Client.create!(id: 1, name: 'michel', email: 'xpto')
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
