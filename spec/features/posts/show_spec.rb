require 'rails_helper'
require_relative '../../support/login_form'

feature 'show created post' do
  let(:user) { create(:user) }
  let(:post) { create(:post, user: user) }

  context 'guest user' do
    before do
      visit "/posts/#{post.id}"
    end

    scenario 'cannot view existing posts' do
      expect(page).to have_content("You need to sign in or sign up before continuing")
    end
  end

  context 'signed in user' do
    subject(:login_form) { LoginForm.new }

    before do
      login_form.visit_page.login_as(user)
      visit("/posts/#{post.id}")
    end

    scenario 'can see created post (s)he created' do
      expect(page).to have_content(post.title)
      expect(page).to have_content(post.content)
    end
  end
end
