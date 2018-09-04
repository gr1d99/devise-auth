# frozen_string_literal: true

require 'rails_helper'
require_relative '../../support/shared_examples'

RSpec.describe Post, type: :model do
  context 'validation' do
    it_behaves_like('validations', :title, :content, :user, :title)
  end
end
