# frozen_string_literal: true

require 'rails_helper'

feature 'search' do
  before do
    create_list(:post, 5, user: build(:user))
  end

  feature 'search form' do
    scenario 'it is visible to user' do
      visit(root_path)
      expect(page).to have_xpath("//form[@id='search-form']")
      expect(page).to have_field('Search')
    end
  end

  context 'when results exists' do
    let(:query_key) { Post.first.title }
    scenario 'user can search for posts' do
      visit(root_path)
      within(:xpath, ".//form[@name='search-form']") do
        fill_in('Search', with: query_key)
        click_on('Search')
      end

      Post.search(query_key).each do |post|
        expect(page).to have_content(post.public_send(:title))
      end

      within(:xpath, ".//form[@name='search-form']") do
        expect(page.find_field('query').value).to eq(query_key)
      end
    end
  end

  context 'when results do not exist' do
    scenario 'user is notified' do
      visit(root_path)
      within(:xpath, ".//form[@name='search-form']") do
        fill_in('Search', with: 'empty posts')
        click_on('Search')
      end

      expect(page).to have_content('Oops!! No search results found')
    end
  end

  context 'when user clicks search button without input' do
    scenario 'user is notified' do
      visit(root_path)
      within(:xpath, ".//form[@name='search-form']") do
        click_on('Search')
      end

      expect(page).to have_content('Oops!! No search results found')
    end
  end
end
