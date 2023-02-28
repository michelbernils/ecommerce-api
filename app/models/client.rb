# frozen_string_literal: true

# Client model
class Client < ApplicationRecord
  has_secure_password

  before_save :downcase_email
  after_create :welcome_mail
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

  def welcome_mail
    email = self.email
    name = self.name
    template = ERB.new(File.read('app/views/registration_mailer/welcome_mail.erb')).result(binding)

    Mail.deliver do
      from 'support@magamike.com'
      to email
      subject 'Welcome to Magamike'
      content_type 'text/html; charset=UTF-8'
      body template
    end
  end
end
