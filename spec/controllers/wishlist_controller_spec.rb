require 'spec_helper'
require 'rails_helper'
require 'byebug'

describe WishlistsController, type: :controller do

  # it 'request index and return 406 Not Acceptable' do
  #   get :index
  #   expect(response).to have_http_status(:not_acceptable)
  # end

  # it 'request index and return 200 OK' do
  #   request.accept = 'application/json'
  #   get :index
  #   expect(response).to have_http_status(:ok)
  # end

  # it 'GET /clients/:id' do
  #   client = Client.create!(id: '1', name: 'michel', email: 'xpto')
  #   request.accept = 'application/json'
  #   get :show, params: { id: client.id }

  #   reponse_body = JSON.parse(response.body)
  #   expect(reponse_body.fetch('id')).to eq(client.id)
  # end

  # it 'POST /clients' do
  #   request.accept = 'application/json'
  #   post :create, params: {client: {name: 'michel2', email: 'xpto2564'}}
  #   expect(response).to have_http_status(:created)
  # end
end
