# frozen_string_literal: true

# Wishlist controller class
class WishlistsController < ApplicationController
  before_action :set_wishlist, only: %i[show update destroy]

  def index
    @wishlist = Wishlist.all

    render json: @wishlist, status: :ok
  end

  def show
    render json: @wishlist
  end

  def create
    @wishlist = Wishlist.new(wishlist_params)
    if @wishlist.save
      render json: @wishlist, status: :created, location: @wishlist
    else
      render json: @wishlist.errors, status: :unprocessable_entity
    end
  end

  def update
    if @wishlist.update(wishlist_params)
      render json: @wishlist
    else
      render json: @wishlist.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @wishlist.destroy

    render json: @wishlist, status: :ok
  end

  private

  def set_wishlist
    @wishlist = Wishlist.find(params[:id])
  end

  def wishlist_params
    params.require(:wishlist).permit(:client_id, products: [])
  end
end
