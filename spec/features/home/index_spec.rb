# frozen_string_literal: true

require 'rails_helper'

feature 'home page' do
  describe 'when there are posts' do
    let(:latest_posts) { Post.latest_posts(4) }
    let(:post) { latest_posts.last }

    before do
      create_list(:post, 10, user: build(:user))
      visit(root_path)
    end

    scenario 'cliking on read more link takes user to post detail page' do
      expect(page).to have_xpath("//a[@href='#{post_path(post)}']")
      page.find("//a[@href='#{post_path(post)}']").click
      expect(page.current_path).to eq(post_path(post))
    end
  end

  describe 'when there are no posts' do
    before { visit(root_path) }

    scenario 'user sees button to create new posts' do
      expect(page).to have_link('Create Post')
    end
  end
end
