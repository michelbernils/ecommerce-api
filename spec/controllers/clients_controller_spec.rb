# require 'spec_helper'
# require 'rails_helper'
# require 'byebug'

# describe ClientsController, type: :controller do

#   context "GET /clients" do
#     it 'should return ok' do
#       request.headers["Content-Type"] = "application/json"
#       get :index

#       expect(response).to have_http_status(:ok)
#     end

#     # it 'should return 404' do
#     #   request.headers["Content-Type"] = "application/json"
#     #   get :index

#     #   expect(response).to have_http_status(:error)
#     # end
#   end

#   context "GET /clients/:id" do
#     it 'should return ok' do
#       client = Client.create(name: 'John Doe', email: 'john.doe@gmail.com')
#       request.headers['Content-Type'] = "application/json"
#       get "/clients/#{client.id}"
      
#       response = JSON.parse(response.body)
#       expect(response['name']).to eq(client.name)
#     end

#     # it 'should return 406' do
#     #   client = Client.create!(name: 'michel', email: 'xpto')
#     #   # request.accept = 'application/json'
#     #   get :show, params: { id: client.id }

#     #   response = JSON.parse(response.body)
#     #   expect(response).to eq(client.id)
#     # end
#   end

#   context "POST /clients/" do
#     it "creates a Client" do
#       client = Client.create(name: 'John Doe', email: 'john.doe@gmail.com')
#       request.headers['Content-Type'] = "application/json"
#       post "/clients", :params => { :clients => {:name => "John Doe", :email => "john.doe@gmail.com"} }
#       get :index
#         expect(response).to have_http_status(:success)

    
#       expect(response).to have_http_status(:created)
#     end
#   end
  
# end


