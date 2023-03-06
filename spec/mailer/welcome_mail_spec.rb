# frozen_string_literal: true

require 'spec_helper'
require 'rails_helper'
require 'byebug'
require 'mail'

RSpec.describe 'sending an email' do
  include Mail::Matchers

  before(:each) do
    Mail::TestMailer.deliveries.clear

    client = Client.create!(id: 1, name: 'john', email: 'john_doe', password_digest: '1234')
    client.run_callbacks(:create)
  end

  it { is_expected.to have_sent_email }
  it { is_expected.to have_sent_email.from('support@magamike.com') }
  it { is_expected.to have_sent_email.to('john_doe') }
end
