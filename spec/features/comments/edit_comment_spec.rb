# frozen_string_literal: true

require 'rails_helper'
require_relative '../../support/login_form'

feature 'edit comment' do
  subject(:login_form) { LoginForm.new }
  let(:user) { create(:user) }
  let(:post) { create(:post, user: user) }
  let(:comment) { create(:comment, user: user, commentable: post) }

  context 'when user is authenticated' do
    before do
      post.comments.append(comment)
      login_form.visit_page.login_as(user)
      visit(post_path(post))
    end

    context 'when user is comment owner' do
      scenario 'user is able to update comment' do
        page.find(
          :xpath, ".//a[@href='#{edit_post_comment_path(post, comment)}']"
        ).click

        within(:xpath, ".//form[@name='edit-comment-form']") do
          expect(page.find(:xpath, ".//textarea[@id='comment_comment']").text)
            .to eql(comment.comment)
          fill_in('Comment', with: 'Updated comment')
          click_on('Update Comment')
        end

        expect(page).to have_content('Comment updated')
        expect(page).to have_content('Updated comment')
      end
    end
  end
end
