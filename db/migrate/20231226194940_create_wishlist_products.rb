class CreateWishlistProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :wishlist_products do |t|
      t.references :wishlist, foreign_key: true, null: false
      t.references :product, foreign_key: true, null: false

      t.timestamps
    end
  end
end
