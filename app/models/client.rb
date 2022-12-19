class Client < ApplicationRecord
  validates :email, uniqueness: true
  has_one :wishlist

  accepts_nested_attributes_for :wishlist, update_only: true, allow_destroy: true

  def as_json(options = {})
    super(
      root: true,
      include: :wishlist
    )
  end
end