require 'rails_helper'
require_relative '../../support/login_form'

feature 'navbar' do
  context 'any user' do
    scenario 'sees home link' do
      visit("/")
      expect(page).to have_link('Home', href: root_path)
    end
  end

  context 'guest user' do
    before do
      visit("/")
    end

    scenario 'sees login link' do
      expect(page).to have_link('Login', href: new_user_session_path)
    end

    scenario 'sees signup link' do
      expect(page).to have_link('Signup', href: new_user_registration_path)
    end
  end

  context 'authenticated users' do
    let(:user) { create(:user) }
    let(:post) { create(:post, user: user) }
    subject(:login_form)  { LoginForm.new }

    before do
      login_form.visit_page.login_as(user)
      visit("/")
    end

    scenario 'sees logout link' do
      expect(page).to have_link('Logout', href: destroy_user_session_path)
    end

    scenario 'sees posts link' do
      expect(page).to have_link('My Posts', href: posts_path)
    end
  end
end