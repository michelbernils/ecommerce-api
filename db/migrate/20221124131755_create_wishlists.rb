# frozen_string_literal: true

class CreateWishlists < ActiveRecord::Migration[7.0]
  def change
    create_table :wishlists do |t|
      t.references :client, null: false, foreign_key: true
      t.string 'products', array: true

      t.timestamps
    end
  end
end
