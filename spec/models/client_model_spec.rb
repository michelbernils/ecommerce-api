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

  describe 'Should send a notify mail to client' do
    subject { Client.new(name: 'treino', email: 'treino') }
    include Mail::Matchers
    Mail::TestMailer.deliveries.clear
    
    it { is_expected.to have_sent_email } # passes if any email at all was sentz
  end

  describe 'Should only have one Wishlist' do  
    subject { Client.new(name: 'john doe', email: 'john.doe@gmail.com') }
    it { should have_one(:wishlist).class_name('Wishlist') }
  end
end
