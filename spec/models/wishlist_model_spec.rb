# frozen_string_literal: true

require 'spec_helper'
require 'rails_helper'
require 'byebug'

describe Wishlist, type: :model do
  context 'Wishlist requirements' do
    it 'Belongs to clients' do  
      should belong_to(:client).class_name('Client')
    end
  end
end
