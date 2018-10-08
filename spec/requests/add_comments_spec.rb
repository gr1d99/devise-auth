# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'AddComments', type: :request do
  let(:user) { create(:user) }
  let(:blog_post) { create(:post, user: user) }

  describe 'POST /posts/:post_id/comments' do
    context 'when user is authenticated and' do
      let(:comment_params) { { comment: attributes_for(:comment) } }

      before do
        sign_in(user)
      end

      context 'when request is valid' do
        it 'returns status 200' do
          post post_comments_path(blog_post), params: comment_params
          expect(response).to have_http_status(302)
        end

        it 'adds comment to post' do
          expect do
            post post_comments_path(blog_post), params: comment_params
          end.to change(Comment, :count).by(1)
        end
      end

      context 'when request is invalid' do
        it 'does not add comment to post' do
          expect do
            post post_comments_path(blog_post), params: { comment: { comment: '' } }
          end.not_to change(Comment, :count)
        end
      end
    end

    context 'when user is not authenticated' do
      before { post post_comments_path(blog_post), params: { comment: '' } }

      it 'returns status 302' do
        expect(response).to have_http_status(302)
      end
    end
  end

  describe 'GET /posts/:post_id/comments/new' do
    context 'when user is authenticated' do
      before do
        sign_in(user)
        get new_post_comment_path(blog_post)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when user is not authenticated' do
      before do
        get new_post_comment_path(blog_post)
      end

      it 'returns status code 302' do
        expect(response).to have_http_status(302)
      end
    end
  end
end
