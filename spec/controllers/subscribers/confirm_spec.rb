# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SubscribersController, type: :controller do
  include_context 'confirmation context'

  describe 'confirm#GET' do
    context 'when token is valid' do
      before { get :confirm, params: { token: valid_token } }

      it_behaves_like '302 redirects'
      it 'marks subscriber as confirmed' do
        valid_subscriber.reload
        expect(valid_subscriber.is_confirmed).to be_truthy
      end
    end

    context 'when token is used' do
      before { get :confirm, params: { token: used_token } }

      it_behaves_like '302 redirects'
      it 'does not change confirmed status' do
        expect(confirmed_subscriber.is_confirmed).to be_truthy
        confirmed_subscriber.reload
        expect(confirmed_subscriber.is_confirmed).to be_truthy
      end
    end

    context 'when token is invalid' do
      before { get :confirm, params: { token: invalid_token } }
      it_behaves_like '302 redirects'
    end
  end
end
