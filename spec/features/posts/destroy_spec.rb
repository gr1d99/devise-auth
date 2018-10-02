# frozen_string_literal: true

require 'rails_helper'
require_relative '../../support/login_form'

feature 'delete post' do
  let(:user) { create(:user) }
  let(:post) { create(:post, user: user) }
  let(:user_2) { create(:user) }
  subject(:login_form) { LoginForm.new }

  before { login_form.visit_page.login_as(user) }

  scenario 'owner deletes post' do
    visit(post_path(post))
    click_on('Delete Post')
    expect(page).to have_content('Post deleted successfully')
    expect(page.current_path).to eq(posts_path)
  end
end
