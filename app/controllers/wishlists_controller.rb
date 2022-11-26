class WishlistsController < ApplicationController
  before_action :set_wishlist, only: [:show, :update, :destroy]

  def index
    @wishlist = Wishlist.all

    render json: @wishlist, status: :ok
  end

  def show
    render json: @wishlist
  end

  def create
    @wishlist = Wishlist.new(wishlist_params)

    @wishlist.save
    render json: @wishlist, status: :created
  end

  def update
    if @wishlist.update(wishlist_params)
      render json: @wishlist
    else
      render json: @wishlist.errors, status: :unprocessable_entity
    end
  end

  def delete
    @wishlist.destroy

    render json: @wishlist, status: :deleted
  end

  private

  def wishlist_params
    params.require(:wishlist).permit(:product)
  end
end