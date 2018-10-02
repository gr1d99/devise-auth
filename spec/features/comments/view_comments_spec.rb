# frozen_string_literal: true

require 'rails_helper'

feature 'view post comments' do
  let(:user) { create(:user) }
  let(:commenter) { create(:user, email: Faker::Internet.unique.email) }
  let(:post) { create(:post, user: user) }

  before do
    create_list(:comment, 10, commentable: post, user: commenter)
    visit(post_path(post))
  end

  it 'shows comments count' do
    expect(page).to have_content("#{Comment.count} comments")
  end

  it 'lists comments' do
    Comment.all.each do |comment|
      expect(page).to have_content(comment.comment)
    end
  end
end
