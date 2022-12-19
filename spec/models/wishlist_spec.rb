require 'spec_helper'
require 'rails_helper'
require 'byebug'

describe Wishlist, type: :model do
  context 'associations' do
    it 'Wishlist belongs to clients' do  
      should belong_to(:client).class_name('Client')
    end
  end

  # describe 'validations' do
  #   it { should validate_uniqueness_of(:products) }
  # end
end
