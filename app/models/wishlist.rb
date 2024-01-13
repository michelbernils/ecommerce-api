# frozen_string_literal: true

# Wishlist model
class Wishlist < ApplicationRecord
  belongs_to :client
  belongs_to :product

  validates :client_id, presence: true
  validates :product_id, presence: true
end
