require 'rails_helper'
require_relative '../../support/login_form'

feature 'add new post' do
  context 'guest user' do
    scenario 'should be redirected to login page' do
      visit('/posts/new')
      expect(page.current_path).to eq(new_user_session_path)
    end
  end

  context 'authenticated user' do
    let(:user) { create(:user) }
    subject(:login_form) { LoginForm.new }

    before do
      login_form.visit_page.login_as(user)
    end

    context 'when form is valid' do
      scenario 'user is able to add new post' do
        visit('/posts/new')

        within('#post-form') do
          fill_in('Title', with: 'Some title')
          fill_in('Content', with: 'Some content')
          click_on('Create')
        end

        expect(page).to have_content('Post created successfully')
        expect(page.current_path).to eq(new_post_path)
      end
    end

    context 'when form is invalid' do
      scenario 'user sees error messages' do
        visit('/posts/new')

        within('#post-form') do
          click_on('Create')
        end

        expect(page).to have_content('Title can\'t be blank')
        expect(page).to have_content('Content can\'t be blank')
      end
    end
  end
end
