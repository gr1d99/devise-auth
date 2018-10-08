# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SubscriptionMailer, type: :mailer do
  let(:subscriber) { create(:subscriber) }

  describe 'send_confirmation' do
    context 'headers' do
      let(:mail) do
        described_class.with(
          email: subscriber.email,
          confirmation_url: subscriber.confirmation_url
        ).send_confirmation
      end

      it 'renders correct subject' do
        expect(mail.subject).to eq('Confirm Subscription')
      end

      it 'sends to the right recipient' do
        expect(mail.to).to eq([subscriber.email])
      end

      it 'renders the correct from email' do
        expect(mail.from).to eq([ENV['DEFAULT_SUBSCRIPTION_MAILER_FROM']])
      end

      it 'includes subscription link' do
        expect(mail.body.encoded).to include(subscriber.token)
      end
    end
  end
end
