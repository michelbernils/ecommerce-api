# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Test wishlist requests', type: :request do
  let(:headers) { { 'Content-Type' => 'application/json' } }
  let(:client) { instance_double(Client, id: 1, name: 'michel', email: 'xpto', password_digest: '12345678') }
  let(:product) { instance_double(Product, id: 1, name: 'iphone', image: 'c.png', url: 'test') }
  let(:wishlist) { instance_double(Wishlist, id: 1, client_id: 1, product_id: 1) }
  let(:product_update) { instance_double(Product, id: 2, name: 'hiphone', image: 'c.png', url: 'test') }

  context 'GET /wishlists index' do
    it '200' do
      get('/wishlists', params: {}, headers: headers)

      expect(response).to have_http_status(200)
    end
  end

  context 'GET /wishlists/:id' do
    it '200' do
      get("/wishlists/#{wishlist.id}", params: {}, headers: headers)

      expect(response).to have_http_status(200)
      expect(wishlist.client_id).to eq(client.id)
      expect(wishlist.product_id).to eq(product.id)
    end
  end

  context 'POST /wishlists' do
    it '201' do
      product = Product.create!(name: 'image', image: 'c.png', url: 'test')
      client = Client.create!(name: 'michel', email: 'rails.world', password: '123456778')
      wishlist = Wishlist.create!(client_id: client.id, product_id: product.id)

      post('/wishlists', params: { wishlist: { client_id: client.id, product_id: product.id } }.to_json, headers: headers)
      response_json = JSON.parse(response.body)
      expect(response).to have_http_status(201)
      expect(response_json['client_id']).to eq(client.id)
      expect(response_json['product_id']).to eq(product.id)
    end
  end

  context 'PUT /wishlists/:id' do
    it 'updates wishlist with new product' do
      product = Product.create!(name: 'image', image: 'c.png', url: 'test')
      client = Client.create!(name: 'michel', email: 'rails.world', password: '123456778')
      wishlist = Wishlist.create!(client_id: client.id, product_id: product.id)

      put("/wishlists/#{wishlist.id}", params: wishlist.to_json, headers: headers)

      response_json = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(response_json['client_id']).to eq(client.id)
      expect(response_json['product_id']).to eq(product.id)
    end
  end

  context 'DELETE /wishlists/:id' do
    it '200' do
      delete("/wishlists/#{wishlist.id}", params: {}, headers: headers)

      expect(response).to have_http_status(204)
    end

    it '404' do
      expect { delete("/wishlists/", params: {}, headers: headers) }.to raise_error(ActionController::RoutingError)
    end
  end
end
