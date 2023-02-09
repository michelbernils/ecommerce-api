# frozen_string_literal: true

require 'spec_helper'
require 'rails_helper'
require 'byebug'
require 'mail'

context 'Client Requirementes' do
  describe 'Should have unique email and case sensitive' do 
    subject { Client.new(name: 'john doe', email: 'john.doe@gmail.com') }
    it { should validate_uniqueness_of(:email).case_insensitive }
  end

  describe 'send email' do
    it 'welcome_mail to send after creating a user' do
      client = Client.create!(name: 'mike', email: 'xp')
      expect(client).to receive(:welcome_mail)
      client.run_callbacks(:create)
    end
  end

  describe 'Should only have one Wishlist' do
    subject { Client.new(name: 'john doe', email: 'john.doe@gmail.com') }
    it { should have_one(:wishlist).class_name('Wishlist') }
  end
end
