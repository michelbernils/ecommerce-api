# frozen_string_literal: true

# Wishlist model
class Wishlist < ApplicationRecord
  belongs_to :client
  has_many :wishlist_products, dependent: :destroy
  has_many :products, through: :wishlist_products

  validate :product_ids_uniqueness

  private

  def product_ids_uniqueness
    errors.add(:product_ids, 'is not unique') unless product_ids == product_ids.uniq
  end
end
