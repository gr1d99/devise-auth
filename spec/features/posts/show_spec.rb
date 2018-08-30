require 'rails_helper'
require_relative '../../support/login_form'

feature 'show created post' do
  let(:user) { create(:user) }
  let(:post) { create(:post, user: user) }

  context 'all users' do
    scenario 'can view post detail' do
      visit("/posts/#{post.id}")
      expect(page).to have_content(post.title)
      expect(page).to have_content(post.content)
    end
  end

  context 'when user is not logged in' do
    scenario '(s)he does not see edit button' do
      visit(post_path(post))
      expect(page).not_to have_link('Edit Post')
    end

    scenario '(s)he does not see delete button' do
      visit(post_path(post))
      expect(page).not_to have_link('Delete Post')
    end
  end

  context 'when post does not exist' do
    scenario 'it shows page not found' do
      visit('/posts/cd12e')
      expect(page).to have_content(/Page not found/)
    end
  end
end
