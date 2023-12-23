# frozen_string_literal: true

# Wishlist model
class Wishlist < ApplicationRecord
  has_and_belongs_to_many :products
  belongs_to :client
  validates :client_id, uniqueness: true
  serialize :products, Array

  validate :products_uniqueness

  private

  def products_uniqueness
    errors.add(:products, 'is not unique') unless products == products.uniq
  end
end
