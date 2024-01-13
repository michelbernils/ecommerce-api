# frozen_string_literal: true

class CreateWishlists < ActiveRecord::Migration[7.0]
  def change
    create_table :wishlists do |t|
      t.references :client, foreign_key: true, null: false
      t.references :product, foreign_key: true, null: false

      t.timestamps
    end
  end
end
