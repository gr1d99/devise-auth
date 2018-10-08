# frozen_string_literal: true

require 'rails_helper'
require_relative '../../support/login_form'

feature 'comment to a post' do
  subject(:login_form) { LoginForm.new }
  let(:user) { create(:user) }
  let(:post) { create(:post, user: user) }

  context 'when user is authenticated' do
    before do
      login_form.visit_page.login_as(user)
      visit(post_path(post))
      click_on('Add your comment')
    end

    it 'displays comment form' do
      expect(page).to have_content('Add your comment')
      expect(page).to have_xpath("//form[@id='post-comment-form']")
      expect(page).to have_xpath("//form//textarea[@id='comment_comment']")
      expect(page).to have_button('Submit Comment')
    end

    context 'when user fills adds comment and click submit comment button' do
      it 'shows success message' do
        within(:xpath, ".//form[@name='post-comment-form']") do
          fill_in('comment_comment', with: 'Some comment')
          click_on('Submit Comment')
        end

        expect(page).to have_content('Comment added')
      end
    end
  end

  context 'when user is not authenticated' do
    before { visit(new_post_comment_path(post)) }

    it 'redirects user to login page' do
      expect(page).not_to have_content('Add your comment')
      expect(page)
        .to have_content('You need to sign in or sign up before continuing.')
    end
  end
end
