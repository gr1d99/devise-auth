# frozen_string_literal: true

require 'rails_helper'
require_relative '../../support/login_form'
require_relative '../../support/features/create_post_helper'

feature 'navigation links' do
  subject(:login_form) { LoginForm.new }

  let(:user) { create(:user) }

  scenario 'has previous and next page links' do
    100.times do |n|
      create(:post, user: user, title: "#{Faker::Book.title}_#{n}")
    end

    visit(posts_path)
    expect(page).to have_content('Previous Page')
    expect(page).to have_content('Next Page')
  end
end
