# frozen_string_literal: true

require 'byebug'

# Products Controller class
class ProductsController < ApplicationController
  wrap_parameters format: %i[json multipart_form]
  before_action :set_product, only: %i[show update destroy]

  def index
    @product = Product.all

    if @products
      render json: @product, status: :ok
    else
      render json: @product
    end
  end

  def create
    img = params[:product][:image]

    if img.present?
      @product = Product.new(product_params)
      upload_image_s3 = UploadImageS3.new(tempfile: img.tempfile, file_name: img.original_filename)
      @product.url = upload_image_s3.upload
    else
      render json: { error: 'Image is missing' }, status: :unprocessable_entity
      return
    end

    if @product.save
      render json: @product, status: :created, location: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  def show
    @product = Product.find(params[:id])
    render json: @product
  end

  def update
    return unless @product.present?

    @product.update(product_params)
    render json: @product, status: :ok
  end

  def destroy
    return unless @product.present?

    @product.destroy
    render json: @product, status: :ok
  end

  private

  def set_product
    @product = Product.find_by(id: params[:id])
  end

  def product_params
    params.require(:product).permit(:image, :url, :name)
  end
end
