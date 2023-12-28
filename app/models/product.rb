# frozen_string_literal: true

# Products model
class Product < ApplicationRecord
  has_many :wishlist_products, dependent: :destroy
  has_many :wishlists, through: :wishlist_products

  validates :image, presence: true
  validates :name, presence: true
  validates :url, presence: true
end
