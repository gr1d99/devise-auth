# frozen_string_literal: true

require 'rails_helper'
require_relative '../../support/shared_examples'

RSpec.describe Post, type: :model do
  describe 'association' do
    it_behaves_like('associations', :user)
  end
end
