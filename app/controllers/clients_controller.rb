# frozen_string_literal: true

require_relative '../clients/wishlist_client'
require 'byebug'

# Client Controller class
class ClientsController < ApplicationController
  before_action :set_client, only: %i[show update destroy]

  def index
    @clients = Client.all

    if @clients
      render json: @clients
    else
      render json: @clients.errors, status: :unprocessable_entity
    end
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
    if @client.present?
      @client.update(client_params)
      render json: @client, status: :ok
    end
  end

  def destroy
    if @client.present?
      @client.destroy
      render json: @client, status: :ok
    end
  end

  private

  def set_client
    @client = Client.find_by(id: params[:id])
  end

  def client_params
    params.require(:client).permit(:name, :email, :password)
  end
end
