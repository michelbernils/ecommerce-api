# frozen_string_literal: true

# Client model
class Client < ApplicationRecord
  before_save :downcase_email

  validates_uniqueness_of :email, case_sensitive: false
  has_one :wishlist

  accepts_nested_attributes_for :wishlist, update_only: true, allow_destroy: true

  def as_json(*)
    super(
      root: true,
      include: :wishlist
    )
  end

  private

  def downcase_email
    self.email = email.downcase
  end
end
