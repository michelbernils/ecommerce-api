class Wishlist < ApplicationRecord
  belongs_to :client

  serialize :products, Array

  def as_json(options = {})
    super(
      root: true,
    )
  end
end