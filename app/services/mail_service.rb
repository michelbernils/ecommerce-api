# frozen_string_literal: true

# Mail Service class
class MailService
  attr_accessor :name, :email, :template

  def initialize(email:, template:, subject:)
    @email = email
    @template = template
    @subject = subject
  end

  def send_mail
    email = self.email
    name = self.name
    template = self.template

    Mail.deliver do
      from 'support@magamike.com'
      to email
      subject subject
      content_type 'text/html; charset=UTF-8'
      body ERB.new(File.read(template.to_s)).result(binding)
    end
  end
end
