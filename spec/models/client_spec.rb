require 'spec_helper'
require 'rails_helper'
require 'byebug'

describe Client, type: :model do
  context 'associations' do
    it 'Client should only have one Wishlist' do  
      should have_one(:wishlist).class_name('Wishlist')
    end
  end

  describe 'validations' do
    it { should validate_uniqueness_of(:email) }
  end
end
