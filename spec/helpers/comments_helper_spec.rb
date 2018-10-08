# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CommentsHelper, type: :helper do
  let(:users) { create_list(:user, 2) }
  let(:post) { create(:post, user: users.first) }
  let(:comment) { create(:comment, user: users.first, commentable: post) }

  describe '.edit_comment_link' do
    context 'when user is owner' do
      before { sign_in(users.first) }

      context 'when post and comment object exists' do
        it 'returns html link' do
          expected_link =
            "<a class=\"edit-comment-link\" href=\"/posts/#{post.id}/comments/#{comment.id}/edit\"><small><span><i class='fas fa-pen'></i></span></small></a>"
          expect(helper.edit_comment_link_for(comment)).to eql(expected_link)
        end
      end
    end

    context 'when user is not owner' do
      before { sign_in(users.second) }

      it 'returns nothing' do
        expect(helper.edit_comment_link_for(comment)).to be_nil
      end
    end
  end

  describe '.delete_comment_link' do
    context 'when user is owner' do
      before { sign_in(users.first) }

      context 'when post and comment object exists' do
        it 'returns html link' do
          expected_link =
            "<a class=\"delete-comment-link\" rel=\"nofollow\" data-method=\"delete\" href=\"/posts/#{post.id}/comments/#{comment.id}\"><small><span class='danger'><i class='fas fa-trash'></i></span></small></a>"
          expect(helper.delete_comment_link_for(comment)).to eql(expected_link)
        end
      end
    end

    context 'when user is not owner' do
      before { sign_in(users.second) }

      it 'returns nothing' do
        expect(helper.delete_comment_link_for(comment)).to be_nil
      end
    end
  end
end
