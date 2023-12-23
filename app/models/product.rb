# frozen_string_literal: true

# Products model
class Product < ApplicationRecord
  validates :image, presence: true
  validates :name, presence: true
  validates :url, presence: true
end
