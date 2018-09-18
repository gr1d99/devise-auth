# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Subscriber, type: :model do
  let(:subscriber) { build(:subscriber) }

  describe 'generate_confirmation_url' do
    it 'generates url' do
      expect(subscriber.confirmation_url).not_to be_nil
    end
  end
end
