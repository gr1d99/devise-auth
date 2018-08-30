require 'rails_helper'

feature 'view all posts' do
  let!(:user) { create(:user) }
  let!(:post_1) { create(:post, user: user, title: Faker::Dune.title) }
  let!(:post_2) { create(:post, user: user) }

  scenario 's(he) can view all posts' do
    visit('/posts')
    expect(page).to have_content(post_1.title)
    expect(page).to have_content(post_2.title)
  end
end
