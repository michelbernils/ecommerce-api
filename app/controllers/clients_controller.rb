class ClientsController < ActionController::Base 
  before_action :set_client, only: [:show, :update, :destroy ]

  def index
    @client = Client.all

    render json: @client, status: :ok
  end

  def show
    render json: @client
  end

  def create
    @client = Client.new(client_params)

    @client.save
    render json: @client, status: :created
  end

  def update
    if @client.update(client_params)
      render json: @client
    else
      render json: @client.errors, status: :unprocessable_entity
    end
  end

  def delete
    @client.destroy

    render json: @client, status: :deleted
  end

  private

  def client_params
    params.require(:client).permit(:name, :email, :wishlist_id)
  end
end