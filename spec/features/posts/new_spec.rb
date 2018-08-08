require 'rails_helper'
require_relative '../../support/login_form'

feature 'post form' do
  context 'guest user' do
    scenario 'view form' do
      visit('/posts/new')
      expect(page)
        .to have_content('You need to sign in or sign up before continuing')
    end
  end

  context 'signed in user' do
    subject(:login_form) { LoginForm.new }
    let(:user) { create(:user) }

    before do
      login_form.visit_page.login_as(user)
    end

    scenario 'user is be able to see new form' do
      title = Faker::Book.title
      content = Faker::Lorem.paragraph

      visit('/posts/new')
      expect(page).to have_content('New Post')

      within('#post-form') do
        fill_in('Title', with: title)
        fill_in('Description', with: content)
      end

      expect(page).to have_field('Title', with: title)
      expect(page).to have_field('Description', with: content)
    end
  end
end
