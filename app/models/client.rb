class Client < ApplicationRecord
  validates :email, uniqueness: true

  has_one :wishlist
end