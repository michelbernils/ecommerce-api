# frozen_string_literal: true

require 'spec_helper'
require 'rails_helper'
require 'byebug'
require 'mail'

context 'Client Requirementes' do
  describe 'Should have unique email and case sensitive' do 
    subject { Client.new(name: 'john doe', email: 'john.doe@gmail.com', password_digest: '1234') }
    it { should validate_uniqueness_of(:email).case_insensitive }
  end

  describe 'Should have password ' do
    subject { Client.new(name: 'john doe', email: 'john.doe@gmail.com', password_digest: '1234') }
    it { should validate_presence_of(:password) }
  end

  describe 'Client' do
    it 'should hash and save the password in the database' do
      client = Client.create(name: 'john doe', email: 'john.doe@gmail.com', password: '12345678')
      expect(client.password_digest).to_not eq('12345678')
    end

    it 'should authenticate a client with a valid password' do
      client = Client.create(name: 'john doe', email: 'john.doe@gmail.com', password: '12345678')
      expect(client.authenticate('12345678')).to eq(client)
    end

    it 'should not authenticate a user with an invalid password' do
      client = Client.create(name: 'john doe', email: 'john.doe@gmail.com', password: '12345678')
      expect(client.authenticate('invalidpassword')).to be_falsey
    end
  end

  describe 'send email' do
    it 'welcome_mail to send after creating a user' do
      client = Client.create!(name: 'mike', email: 'xp', password_digest: '1234')
      expect(client).to receive(:welcome_mail)
      client.run_callbacks(:create)
    end
  end

  describe 'Should only have one Wishlist' do
    subject { Client.new(name: 'john doe', email: 'john.doe@gmail.com', password_digest: '1234') }
    it { should have_one(:wishlist).class_name('Wishlist') }
  end
end
