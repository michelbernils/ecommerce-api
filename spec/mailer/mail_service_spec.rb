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
  let(:client) { Client.create!(id: 1, name: 'john', email: 'john_doe', password_digest: '123456789') }

  before(:each) do
    Mail::TestMailer.deliveries.clear

    client.run_callbacks(:create)
  end

  it 'should instance the class correctly' do
    expect(mail_service.email).to eq(email)
    expect(mail_service.template).to eq(template)
    expect(mail_service.subject).to eq(subject)
    expect(mail_service.from).to eq(from)
  end

  it { is_expected.to have_sent_email }
  it { is_expected.to have_sent_email.from(mail_service.from) }
  it { is_expected.to have_sent_email.to(client.email) }
end
