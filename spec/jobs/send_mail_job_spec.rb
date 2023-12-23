# frozen_string_literal: true

require 'spec_helper'
require 'rails_helper'
require 'mail'

RSpec.describe 'MailService class' do
  include Mail::Matchers

  let(:email) { 'mike@xpto.com' }
  let(:template) { 'app/mailers/welcome_mail.html.erb' }
  let(:name) { 'Michel' }
  let(:subject) { 'Welcome' }
  let(:from) { 'support@magamike.com' }
  let(:mail_service) { MailService.new(email:, template:, subject:, from:) }

  it 'sends an email' do
    allow(mail_service).to receive(:send_mail).and_return(true)
    mail_service.send_mail

    expect(mail_service).to have_received(:send_mail)
  end

  it 'send email using background job' do
    SendMailJob.perform_now(name:, email:, template:, subject:, from:)

    mail = ActionMailer::Base.deliveries.last
    expect(mail.to).to eq([email])
    expect(mail.from).to eq([from])
    expect(mail.subject).to eq(subject)
    expect(mail.body.raw_source).to include(name)
  end
end
