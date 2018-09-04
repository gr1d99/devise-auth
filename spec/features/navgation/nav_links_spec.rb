require 'rails_helper'
require_relative '../../support/login_form'

feature 'navbar' do
  context 'any user' do
    before { visit("/") }
    scenario 'sees home link' do
      expect(page).to have_link('Home', href: root_path)
    end

    scenario 'sees posts link' do
      expect(page).to have_link('Posts', href: posts_path)
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

    scenario 'does not see protected links' do
      expect(page).not_to have_link('Logout', href: destroy_user_session_path)
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

    scenario 'sees create post link' do
      expect(page).to have_link('Create Post', href: new_post_path)
    end
  end
end
