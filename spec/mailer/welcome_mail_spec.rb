# frozen_string_literal: true

require 'spec_helper'
require 'rails_helper'
require 'byebug'
require 'mail'

RSpec.describe 'sending an email' do
  include Mail::Matchers

  before(:each) do
    Mail::TestMailer.deliveries.clear

    client = Client.create!(id: 10, name: 'lehsim', email: 'xpssz')
    client.run_callbacks(:create)
  end

  it { is_expected.to have_sent_email } # passes if any email at all was sent
  it { is_expected.to have_sent_email.from('support@magamike.com') }
  it { is_expected.to have_sent_email.to('xpssz') }
end
