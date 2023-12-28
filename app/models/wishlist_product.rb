# frozen_string_literal: true

# WishlistProduct class
class WishlistProduct < ApplicationRecord
  belongs_to :wishlist
  belongs_to :product
end
