# frozen_string_literal: true

require 'rails_helper'

feature 'delete comment' do
  subject(:login_form) { LoginForm.new }
  let!(:users) { create_list(:user, 2) }
  let!(:post) { create(:post, user: users.first) }
  let!(:comment) { create(:comment, commentable: post, user: users.first) }

  context 'when user is authenticated' do
    context 'when user is owner' do
      before do
        login_form.visit_page.login_as(users.first)
      end

      scenario 'user is able to see comment delete icon' do
        visit(post_path(post))
        expect(page)
          .to have_selector(
            :xpath,
            ".//a[@href='#{post_comment_path(post, comment)}']"
          )
      end
    end

    context 'when user is not owner' do
      before do
        login_form.visit_page.login_as(users.last)
      end

      scenario 'user is not able to see comment delete icon' do
        visit(post_path(post))
        expect(page)
          .not_to have_selector(
            :xpath,
            ".//a[@href='#{post_comment_path(post, comment)}']"
          )
      end
    end
  end

  context 'when user is not authenticated' do
    scenario 'user is not able to see comment delete icon' do
      visit(post_path(post))
      expect(page)
        .not_to have_selector(
          :xpath,
          ".//a[@href='#{post_comment_path(post, comment)}']"
        )
    end
  end
end
