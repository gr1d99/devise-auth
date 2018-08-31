# frozen_string_literal: true

require 'rails_helper'
require_relative '../../support/login_form'
require_relative '../../support/features/create_post_helper'

feature 'view all posts' do
  include CreatePostHelper

  subject(:login_form) { LoginForm.new }
  let(:user) { create(:user) }
  let(:title) { Faker::Book.title }
  let(:content) { Faker::Lovecraft.paragraph }

  context 'when there are posts' do
    scenario 's(he) can view all posts' do
      login_form.visit_page.login_as(user)
      create_post
      expect(page).to have_content('Post created successfully')
      visit(posts_path)

      expect(page).to have_content(title)
      expect(page).to have_content(content)
    end
  end

  context 'when there are no posts' do
    before { visit(posts_path) }

    scenario 'users sees no posts available' do
      expect(page).to have_content('Oops! There are no posts at the moment ;)')
    end
  end
end
