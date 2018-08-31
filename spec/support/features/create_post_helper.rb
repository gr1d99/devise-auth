# frozen_string_literal: true

require 'rails_helper'

module CreatePostHelper
  def create_post
    visit(new_post_path)
    expect(page).to have_content('New Post')

    within('#post-create-form') do
      fill_in('Title', with: title)
      fill_in('Content', with: content)
      click_on('Create')
    end
  end
end
