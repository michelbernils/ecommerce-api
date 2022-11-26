class Client < ApplicationRecord
  validates :email, uniqueness: true
  validates :wishlist_id, uniqueness: true
  has_one :wishlist
end