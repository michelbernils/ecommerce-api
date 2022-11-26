class CreateWishlists < ActiveRecord::Migration[7.0]
  def change
    create_table :wishlists do |t|
      t.integer :product

      t.timestamps
    end
  end
end
