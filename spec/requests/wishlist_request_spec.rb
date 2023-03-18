# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Test wishlist requests', type: :request do
  let(:headers) { { 'Content-Type' => 'application/json' } }

  before(:each) do
    @client = Client.create!(name: 'michel', email: 'xpto', password_digest: '12345678')
    @wishlist = Wishlist.create!(client_id: @client.id, products: %w[1 2 3 4])
    @client_post = Client.create!(name: 'michel', email: 'xpto2', password_digest: '12345678')
  end

  let(:wishlist_post) { { wishlist: { client_id: @client_post.id, products: %w[1 2 3 4] } } }

  after(:each) do
    @wishlist.destroy
    @client.destroy
    @client_post.destroy
  end

  context 'GET /wishlists index' do
    it '200' do
      get '/wishlists', params: {}, headers: headers

      expect(response).to have_http_status(200)
    end
  end

  context 'GET /wishlists/:id' do
    it '200' do
      get "/wishlists/#{@wishlist.id}", params: {}, headers: headers

      expect(response).to have_http_status(200)
    end
  end

  context 'POST /wishlists' do
    it '201' do
      post '/wishlists', params: wishlist_post.to_json, headers: headers

      expect(response).to have_http_status(201)
      expect(response.parsed_body['client_id']).to eq(wishlist_post[:wishlist][:client_id])
      expect(response.parsed_body['products']).to eq(wishlist_post[:wishlist][:products])
    end
  end

  context 'PUT /wishlists/:id' do
    it '200' do
      wishlist_update = { products: %w[1 2 3 4 5] }
      put "/wishlists/#{@wishlist.id}", params: wishlist_update.to_json, headers: headers

      expect(response).to have_http_status(200)
      expect(response.parsed_body['id']).to eq(@wishlist.id)
      expect(response.parsed_body['products']).to eq(wishlist_update[:products])
    end

    it '204' do
      put '/wishlists/2', params: {}.to_json, headers: headers

      expect(response).to have_http_status(204)
    end
  end

  context 'DELETE /wishlists/:id' do
    it '200' do
      delete "/wishlists/#{@wishlist.id}", params: {}, headers: headers

      expect(response).to have_http_status(200)
    end

    it '204' do
      delete '/wishlists/2', params: {}.to_json, headers: headers

      expect(response).to have_http_status(204)
    end
  end
end
