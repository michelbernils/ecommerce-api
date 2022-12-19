require 'byebug'

class WishlistClient
  attr_accessor :client

  def initialize(client:)
    @client = client
  end

  def get_products
    client.wishlist.products.map do |product|
      p product.to_s.merge
    end
  end
end
