# frozen_string_literal: true

require 'rails_helper'

feature 'confirm subscription' do
  include SubscribersControllerHelper

  include_context 'confirmation context'

  context 'when token is valid' do
    before { visit("/subscribe/confirm/#{valid_token}") }

    scenario 'user sees success notification' do
      expect(page).to have_content(successful_subscription_msg)
    end
  end

  context 'when token is used' do
    before { visit("/subscribe/confirm/#{used_token}") }

    scenario 'user is notified that he/she has already subscribed' do
      expect(page).to have_content(already_subscribed_msg)
    end
  end

  context 'when token is invalid' do
    before { visit("/subscribe/confirm/#{invalid_token}") }

    scenario 'user is notified to subscribe again' do
      expect(page)
        .to have_content('The link you used is invalid, please subscribe again')
    end
  end
end
