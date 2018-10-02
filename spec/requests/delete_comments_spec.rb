# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'DeleteComments', type: :request do
  let(:users) { create_list(:user, 2) }
  let!(:post) { create(:post, user: users.first) }
  let!(:comment) { create(:comment, user: users.first, commentable: post) }

  describe 'DELETE /posts/:post_id/comments/:id' do
    context 'when user is authenticated' do
      context 'when user is owner' do
        before { sign_in(users.first) }

        it 'deletes comment from post comments' do
          expect { delete post_comment_path(post, comment) }
            .to change(Comment, :count).by(-1)
        end

        it 'redirects to post detail page' do
          delete post_comment_path(post, comment)
          expect(response).to have_http_status(302)
        end
      end

      context 'when user is not owner' do
        before { sign_in(users.last) }

        it 'returns status code 404' do
          delete post_comment_path(post, comment)
          expect(response).to have_http_status(404)
        end
      end

      context 'when comment does not exist' do
        it 'returns status code 404' do
          delete "/posts/#{post.id}/comments/0"
          expect(response).to have_http_status(302)
        end
      end
    end

    context 'when user is not authenticated' do
      it 'returns status code 302' do
        delete post_comment_path(post, comment)
        expect(response).to have_http_status(302)
      end
    end
  end
end
