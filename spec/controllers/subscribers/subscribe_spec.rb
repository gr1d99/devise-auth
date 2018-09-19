# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SubscribersController, type: :controller do
  include SubscribersControllerHelper

  describe 'subscribe#POST' do
    describe 'when email is provided' do
      let(:email) { 'some-email@example.com' }

      before { get :subscribe, params: { email: email } }

      context 'and is new' do
        it_behaves_like '302 redirects'
        it 'confirmation email is sent' do
          expect(last_email.to).to eq([email])
          expect(last_email.subject).to eq('Confirm Subscription')
          expect(last_email.encoded)
            .to include(Subscriber.last.confirmation_url)
        end
      end

      context 'when email exists and has not been confirmed' do
        it_behaves_like '302 redirects'
        it 're-sends confirmation url' do
          subscriber = Subscriber.find_by_email(email)
          expect { get :subscribe, params: { email: email } }
            .not_to change { subscriber.confirmation_url }
          expect(last_email.to).to eq([email])
        end
      end
    end

    describe 'when email is not provided' do
      before { post :subscribe, params: { email: '' } }

      it_behaves_like '302 redirects'
      it 'does not send email' do
        expect(last_email).to be_nil
      end
    end
  end
end
