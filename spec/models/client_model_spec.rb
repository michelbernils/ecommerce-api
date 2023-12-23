# frozen_string_literal: true

require 'spec_helper'
require 'rails_helper'
require 'mail'

context 'Client Requirementes' do
  let(:client) { Client.new(name: 'john doe', email: 'john.doe@gmail.com', password: '12345678') }
  include Mail::Matchers

  before(:each) do
    Mail::TestMailer.deliveries.clear

    client.run_callbacks(:create)
  end

  describe 'Should have unique email and case sensitive' do
    subject { client }
    it { should validate_uniqueness_of(:email).case_insensitive }
  end

  describe 'Should have password ' do
    subject { client }
    it { should validate_presence_of(:password) }
  end

  describe 'Client' do
    it 'should hash and save the password in the database' do
      expect(client.password_digest).to_not eq('1234567')
    end

    it 'should authenticate a client with a valid password' do
      expect(client.authenticate(client.password)).to eq(client)
    end

    it 'should not authenticate a user with an invalid password' do
      expect(client.authenticate('invalidpassword')).to be_falsey
    end
  end

  describe 'send email' do
    it 'welcome_mail to send after creating a user' do
      expect(client).to receive(:send_welcome_mail)
      client.run_callbacks(:create)
    end
  end

  describe 'Should only have one Wishlist' do
    subject { client }
    it { should have_one(:wishlist).class_name('Wishlist') }
  end
end
