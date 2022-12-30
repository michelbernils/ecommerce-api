# frozen_string_literal: true

require 'spec_helper'
require 'rails_helper'
require 'byebug'

context 'Client Requirementes' do
  describe 'Should have unique email and case sensitive' do 
    subject { Client.new(name: 'john doe', email: 'john.doe@gmail.com') }
    it { should validate_uniqueness_of(:email).case_insensitive }
  end

  describe 'Should only have one Wishlist' do  
    subject { Client.new(name: 'john doe', email: 'john.doe@gmail.com') }
    it { should have_one(:wishlist).class_name('Wishlist') }
  end
end
