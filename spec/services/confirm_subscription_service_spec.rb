# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ConfirmSubscriptionService do
  let(:subscriber) { create(:subscriber) }

  describe '.call' do
    it 'change is_confirmed true' do
      expect { described_class.call(subscriber) }
        .to change { subscriber.is_confirmed }.from(false).to(true)
    end
  end
end
