# frozen_string_literal: true

require 'spec_helper'
require 'rails_helper'
require 'byebug'
require 'mail'

RSpec.describe 'MailService class' do
  include Mail::Matchers

  let(:email) { 'mike@xpto.com' }
  let(:template) { 'app/mailers/welcome_mail.html.erb' }
  let(:subject) { 'Welcome' }
  let(:from) { 'support@magamike.com' }
  let(:mail_service) { MailService.new(email: email, template: template, subject: subject, from: from) }

  it 'sends an email' do
    allow(mail_service).to receive(:send_mail).and_return(true)
    mail_service.send_mail

    expect(mail_service).to have_received(:send_mail)
  end
end
