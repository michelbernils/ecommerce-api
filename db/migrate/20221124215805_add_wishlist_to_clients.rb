class AddWishlistToClients < ActiveRecord::Migration[7.0]
  def change
    add_reference :wishlists, :client
  end
end
