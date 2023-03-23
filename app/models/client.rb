# frozen_string_literal: true

# Client model
class Client < ApplicationRecord
  has_secure_password

  before_save :downcase_email
  after_create :send_welcome_mail

  validates_uniqueness_of :email, case_sensitive: false

  validates :password, length: { minimum: 6 }, allow_nil: true

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

  def send_welcome_mail
    MailService.new(email: email, template: 'app/mailers/welcome_mail.html.erb', subject: 'Welcome to MagaMike', from: 'support@magamike.com').send_mail
  end
end
