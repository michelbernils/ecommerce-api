# frozen_string_literal: true

# SendMail Job
class SendMailJob < ApplicationJob
  queue_as :default

  def perform(name:, email:, template:, subject:, from:)
    Mail.deliver do
      from from
      to email
      subject subject
      content_type 'text/html; charset=UTF-8'
      body ERB.new(File.read(template.to_s)).result(binding)
    end
  end
end
