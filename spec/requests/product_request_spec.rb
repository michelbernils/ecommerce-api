# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Test products requests', type: :request do
  let(:headers) { { 'Content-Type' => 'application/json'} }
  let(:product) { Product.create!(name: 'iphone', image: fixture_file_upload('spec/fixtures/c.png', 'image/png'), url: 'test') }
  let(:product_json) { { "product": { "name": 'iphone', 'image': fixture_file_upload('spec/fixtures/c.png', 'image/png'), 'url': 'test' } } }

  context 'get /products index' do
    it '200 OK' do
      get('/products', params: {}, headers:)

      expect(response).to have_http_status(200)
    end
  end

  context 'get /products/:id' do
    it '200' do
      get("/products/#{product.id}", params: {}, headers:)

      parsed_response = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(parsed_response['name']).to eq(product.name)
      expect(parsed_response['image']).to be_a(Rack::Test::UploadedFile)
      expect(parsed_response['url']).to eq(product.url)
    end
  end

  context 'post /products/' do
    it '201' do
      post('/products', params: product_json.to_json, headers: headers)

      expect(response).to have_http_status(201)
      expect(response.parsed_body['product']['name']).to eq(product_json[:product][:name])
      expect(response.parsed_body['product']['image']).to eq(product_json[:product][:image])
      expect(response.parsed_body['product']['url']).to eq(product_json[:product][:url])
    end

    it 'Parameters Missing' do
      post '/products/', params: {}.to_json, headers: headers

      expect(response).to have_http_status(422)
      expect(response.parsed_body['error']).to eq('Parameters missing')
    end
  end


  context 'put /products/:id' do
    product_update = { 'name': 'iphone 5s', 'image': 'iphone5s.jpg', url: '' }

    it '201' do
      put("/products/#{product.id}", params: product_update.to_json, headers:)

      expect(response).to have_http_status(200)
      expect(response.parsed_body['product']['name']).to eq(product_update[:name])
      expect(response.parsed_body['product']['image']).to eq(product_update[:image])
      expect(response.parsed_body['product']['url']).to eq(product_update[:url])
    end

    it '204' do
      put('/products/1', params: {}.to_json, headers:)

      expect(response).to have_http_status(204)
    end
  end

  context 'delete /products/:id' do
    it '200' do
      delete("/products/#{product.id}", params: {}, headers:)

      expect(response).to have_http_status(200)
    end

    it '204' do
      delete('/products/1', params: {}, headers:)

      expect(response).to have_http_status(204)
    end
  end
end
