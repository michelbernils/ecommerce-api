require_relative '../clients/wishlist_client.rb'

class ClientsController <  ApplicationController
  before_action :set_client, only: [:show, :update, :destroy ]

  def index
    @clients = Client.all

    render json: @clients
  end

  def show
    render json: @client
  end

  def create
    @client = Client.new(client_params)

    if @client.save
      render json: @client, status: :created, location: @client
    else
      render json: @client.errors, status: :unprocessable_entity
    end
  end

  def update
    if @client.update(client_params)
      render json: @client
    else
      render json: @client.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @client.destroy

    render json: @client, status: :ok
  end

  private

  def set_client
    @client = Client.find(params[:id])
  end

  def client_params
    params.require(:client).permit(:name, :email, wishlist_attributes: [:client_id, :products])
  end
end