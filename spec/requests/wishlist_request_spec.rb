# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Test wishlist requests', type: :request do
  let(:wishlist_post) { { "client_id": 1, "products": ["1","2","3","4"] } }

  before(:each) do
    Client.create!(id: 1, name: 'michel', email: 'xpto', password_digest: '1234')
  end

  after(:each) do
    Client.first.destroy
  end

  context 'get /wishlist index' do
    it '200 OK' do
      headers = { 'Content-Type' => 'application/json' }
      get '/wishlists', params: {}, headers: headers

      expect(response).to have_http_status(200)
    end
  end

  context 'get /wishlist/:id' do
    it '200 OK' do
      wishlist_create = Wishlist.create!(client_id: 1, products: [1, 2, 3, 4])
      headers = { 'Content-Type' => 'application/json' }
      get "/wishlists/#{wishlist_create.id}", params: {}, headers: headers

      expect(response).to have_http_status(200)
    end
  end

  context 'post /wishlist/:id' do
    it '200 OK' do
      headers = { 'Content-Type' => 'application/json' }
      post '/wishlists/', params: wishlist_post.to_json, headers: headers

      expect(response).to have_http_status(201)
      expect(wishlist_post[:client_id]).to eq(1)
      expect(wishlist_post[:products]).to eq(%w[1 2 3 4])
    end

    it 'Parameters Missing' do
      headers = { 'Content-Type': 'application/json' }
      expect { post '/wishlists/', params: {}, headers: headers }.to raise_error(ActionController::ParameterMissing)
    end
  end

  context 'put /wishlist/:id' do
    it '200' do
      headers = { 'Content-Type' => 'application/json' }
      wishlist_create = Wishlist.create!(client_id: 1, products: %w[1 2 3 4])
      wishlist_update = { 'products': %w[1 2 3 4 5] }
      put "/wishlists/#{wishlist_create.client_id}", params: wishlist_update.to_json, headers: headers

      expect(response).to have_http_status(200)
      expect(wishlist_create[:client_id]).to eq(1)
      expect(wishlist_create[:products]).to eq(%w[1 2 3 4])
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
      wishlist_create  = Wishlist.create!(client_id: 1, products: %w[1 2 3 4])
      delete "/wishlists/#{wishlist_create.client_id}", params: {}, headers: headers

      expect(response).to have_http_status(200)
    end

    it '204' do
      headers = { 'Content-Type': 'application/json' }
      delete '/wishlists/1', params: {}, headers: headers
      expect(response).to have_http_status(204)
    end
  end
end
