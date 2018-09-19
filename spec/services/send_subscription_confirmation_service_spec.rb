# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SendSubscriptionConfirmationService, type: :service do
  let(:subscriber) { create(:subscriber) }

  describe '.call' do
    it 'sends  email' do
      described_class.call(subscriber)
      expect(last_email.to).to eq([subscriber.email])
    end
  end
end
