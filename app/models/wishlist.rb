class Wishlist < ApplicationRecord
  belongs_to :client
  validates :products, uniqueness: true

  serialize :products, Array
end