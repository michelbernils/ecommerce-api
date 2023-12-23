# frozen_string_literal: true

# Mail Service class
class MailService
  attr_accessor :name, :email, :template, :subject, :from

  def initialize(email:, template:, subject:, from:)
    @email = email
    @template = template
    @subject = subject
    @from = from
  end

  def send_mail
    email = self.email
    name = self.name
    template = self.template
    from = self.from
    subject = self.subject

    Mail.deliver do
      from from
      to email
      subject subject
      content_type 'text/html; charset=UTF-8'
      body ERB.new(File.read(template.to_s)).result(binding)
    end
  end
end
