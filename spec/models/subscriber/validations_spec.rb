# frozen_string_literal: true

require 'rails_helper'
require_relative '../../support/shared_examples'

RSpec.describe Subscriber, type: :model do
  it_behaves_like 'validations', :email
  it_behaves_like 'uniqueness', :token
end
