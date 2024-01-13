# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Test products requests', type: :request do
  let(:headers) { { 'Content-Type' => 'application/json'} }
  let!(:product) { Product.create!(name: 'iphone', image: fixture_file_upload(Rails.root.join('spec', 'fixtures', 'c.png'), 'image/png'), url: 'test') }
  let(:product_double) { instance_double(Product, id: 1, name: 'iphone', image: 'c.png', url: 'test') }

  context 'get /products index' do
    it '200 OK' do
      get('/products', params: {}, headers:)
      expect(response).to have_http_status(200)
    end
  end

  context 'get /products/:id' do
    it '200' do
      get("/products/#{product_double.id}", params: {}, headers:)

      parsed_response = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(parsed_response['name']).to eq(product_double.name)
      expect(parsed_response['image']).to be_a(String)
      expect(parsed_response['url']).to eq(product_double.url)
    end
  end

  context 'post /products/' do
    it 'creates a new product with an image' do
      file = fixture_file_upload('c.png', 'image/png')

      post '/products', params: { name: 'iphone', image: file, url: 'test' }

      response_json = JSON.parse(response.body)

      expect(response).to have_http_status(201)
      expect(response_json['name']).to eq('iphone')
      expect(response_json['url']).to be_present
      # expect(response_json['image']).to eq(ActionDispatch::Http::UploadedFile) -> eu nao sei como resolver isso, estou recebendo um action dispatch.
    end

    it 'Parameters Missing' do
      expect { post '/products/', params: {}, headers: headers }.to raise_error(ActionController::ParameterMissing)
    end
  end

  context 'put /products/:id' do
    it '201' do
      product_update = { "product": { "name": 'iphone', "image": '', "url": 'test' } }

      put("/products/#{product.id}", params: product_update.to_json, headers:)

      parsed_response = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(parsed_response['name']).to eq(product_update[:product][:name])
      expect(parsed_response['image']).to eq(product_update[:product][:image])
      expect(parsed_response['url']).to eq(product_update[:product][:url])
    end

    it 'returns an error for non-existent product' do
      put('/clients/1', params: {}.to_json, headers:)

      expect(response).to have_http_status(204)
    end
  end

  context 'delete /products/:id' do
    it '200' do
      product_delete = Product.create!(name: 'iphone', image: fixture_file_upload(Rails.root.join('spec', 'fixtures', 'c.png'), 'image/png'), url: 'test')
      delete("/products/#{product_delete.id}", params: {}, headers:)

      expect(response).to have_http_status(200)
    end

    it '204' do
      delete('/products/2', params: {}, headers:)

      expect(response).to have_http_status(204)
    end
  end
end
