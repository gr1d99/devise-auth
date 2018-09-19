# frozen_string_literal: true

require 'rails_helper'

feature 'subscribe' do
  include SubscribersControllerHelper

  before { visit(root_url) }

  describe 'subscribe user subscription' do
    let(:email) { 'test@user.com' }

    context 'user provides new email' do
      scenario 'success notification is displayed' do
        within("//form[@id='subscribe-form']") do
          find(:xpath, "//input[@id='email']").set(email)
          click_on('Subscribe')
        end
        expect(page).to have_content(new_confirmation_msg)
      end
    end

    context 'when user provides already subscribed email' do
      before do
        create(:subscriber, email: email)
      end

      scenario 'user sees notification that he/she is subscribed' do
        within("//form[@id='subscribe-form']") do
          find(:xpath, "//input[@id='email']").set(email)
          click_on('Subscribe')
        end
      end
    end

    context 'user provides existing unconfirmed email' do
      before { create(:subscriber, email: email, is_confirmed: true) }

      scenario 'user is notified that confirmation has been sent again' do
        within("//form[@id='subscribe-form']") do
          find(:xpath, "//input[@id='email']").set(email)
          click_on('Subscribe')
        end
        expect(page).to have_content(already_subscribed_msg)
      end
    end

    context 'when user does not provide email' do
      scenario 'he/she is notified that email is required' do
        click_on('Subscribe')
        expect(page).to have_content('Subscription E-mail address is required')
      end
    end
  end
end
