# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Test wishlist requests', type: :request do
  context 'get /wishlist index' do
    it '200 OK' do
      headers = { 'Content-Type' => 'application/json' }
      get '/wishlists', params: {}, headers: headers

      expect(response).to have_http_status(200)
    end
  end

  context 'get /wishlist/:id' do
    it '200 OK' do
      client = Client.create!(id: 1, name: 'michel', email: 'xpto')
      wishlist = Wishlist.create!(client_id: 1, products: [1, 2, 3, 4])
      headers = { 'Content-Type' => 'application/json' }
      get "/wishlists/#{wishlist.id}", params: {}, headers: headers

      expect(response).to have_http_status(200)
    end
  end

  context 'post /wishlist/:id' do
    it '200 OK' do
      headers = { 'Content-Type' => 'application/json' }
      client = Client.create!(id: 1, name: 'michel', email: 'xpto')
      wishlist = { 'client_id': 1, 'products': %w[1 2 3 4] }
      post '/wishlists/', params: wishlist.to_json, headers: headers

      expect(response).to have_http_status(201)
      expect(wishlist[:client_id]).to eq(1)
      expect(wishlist[:products]).to eq(%w[1 2 3 4])
    end

    it 'Parameters Missing' do
      headers = { 'Content-Type': 'application/json' }
      expect { post '/wishlists/', params: {}, headers: headers }.to raise_error(ActionController::ParameterMissing)
    end
  end

  context 'put /wishlist/:id' do
    it '200' do
      headers = { 'Content-Type' => 'application/json' }
      client = Client.create!(id: 1, name: 'michel', email: 'xpto')
      wishlist = Wishlist.create!(client_id: 1, products: %w[1 2 3 4])
      wishlist_update = { 'products': %w[1 2 3 4 5] }
      put "/wishlists/#{wishlist.client_id}", params: wishlist_update.to_json, headers: headers

      expect(response).to have_http_status(200)
      expect(wishlist[:client_id]).to eq(1)
      expect(wishlist[:products]).to eq(%w[1 2 3 4])
      expect(wishlist_update[:products]).to eq(%w[1 2 3 4 5])
    end

    it '204' do
      headers = { 'Content-Type' => 'application/json' }
      wishlist_update = { 'products': %w[1 2 3 4 5] }
      put '/wishlists/1', params: {}.to_json, headers: {}

      expect(response).to have_http_status(204)
    end
  end

  context 'delete /wishlist/:id' do
    it '200' do
      headers = { 'Content-Type': 'application/json' }
      client = Client.create!(id: 1, name: 'michel', email: 'xpto')
      wishlist = Wishlist.create!(client_id: 1, products: %w[1 2 3 4])
      delete "/wishlists/#{wishlist.client_id}", params: {}, headers: headers

      expect(response).to have_http_status(200)
    end

    it '204' do
      headers = { 'Content-Type': 'application/json' }
      delete '/wishlists/1', params: {}, headers: headers
      expect(response).to have_http_status(204)
    end
  end
end
