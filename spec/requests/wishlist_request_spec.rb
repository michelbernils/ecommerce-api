# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Test wishlist requests', type: :request do
  let(:headers) { { 'Content-Type' => 'application/json' } }
  let(:client) { Client.create!(name: 'michel', email: 'xpto', password_digest: '12345678') }
  let(:product) { Product.create!(name: 'iphone', image: fixture_file_upload('spec/fixtures/c.png', 'image/png'), url: 'test') }
  let(:wishlist_post) { { wishlist: { client_id: client.id, products: [product.id] } } }
  let(:wishlist) { Wishlist.create!(client_id: client.id, products: [product]) }

  context 'GET /wishlists index' do
    it '200' do
      get('/wishlists', params: {}, headers:)

      expect(response).to have_http_status(200)
    end
  end

  context 'GET /wishlists/:id' do
    it '200' do
      get("/wishlists/#{wishlist.id}", params: {}, headers:)

      parsed_response = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(parsed_response['client_id']).to eq(wishlist.id)
      expect(parsed_response['products']).to be_an_instance_of(Array)
    end
  end

  context 'POST /wishlists' do
    it '201' do
      post('/wishlists', params: { wishlist: { client_id: client.id, products: [product.id] } }.to_json, headers: headers)

      expect(response).to have_http_status(201)
      expect(response.parsed_body['client_id']).to eq(client.id)
      expect(response.parsed_body['products']).to eq([product.id])
    end
  end

  context 'PUT /wishlists/:id' do
    it '200' do
      wishlist_update = { products: [product.id] }
      put("/wishlists/#{wishlist.id}", params: wishlist_update.to_json, headers: headers)

      expect(response).to have_http_status(200)
      expect(response.parsed_body['id']).to eq(wishlist.id)
      expect(response.parsed_body['products']).to eq(wishlist_update[:products])
    end

    it '204' do
      put('/wishlists/2', params: {}.to_json, headers: headers)

      expect(response).to have_http_status(204)
    end
  end

  context 'DELETE /wishlists/:id' do
    it '200' do
      delete("/wishlists/#{wishlist.id}", params: {}, headers: headers)

      expect(response).to have_http_status(200)
    end

    it '204' do
      delete('/wishlists/2', params: {}.to_json, headers: headers)

      expect(response).to have_http_status(204)
    end
  end
end
