# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Edit Comments', type: :request do
  describe 'GET /posts/:post_id/comments/:id/edit' do
    let(:users) { create_list(:user, 2) }
    let(:post) { create(:post, user: users.first) }
    let(:comment) do
      create(:comment,
             comment: Faker::Lorem.paragraph,
             commentable: post,
             user: users.first)
    end

    context 'when user is authenticated' do
      before do
        sign_in(users.first)
        get edit_post_comment_path(post, comment)
      end

      context 'when user is owner of comment' do
        it 'returns status code 200' do
          expect(response).to have_http_status(200)
        end
      end

      context 'when user is not owner of comment' do
        before do
          sign_in(users.second)
          get edit_post_comment_path(post, comment)
        end

        it 'returns status code 404' do
          expect(response).to have_http_status(404)
        end
      end

      context 'when post does not exist' do
        before { get "/posts/0/comments/#{comment.id}/edit" }

        it 'returns status code 404' do
          expect(response).to have_http_status(404)
        end
      end

      context 'when comment does not exist' do
        before { get "/posts/#{post.id}/comments/0/edit" }

        it 'returns status code 404' do
          expect(response).to have_http_status(404)
        end
      end
    end

    context 'when user is not authenticated' do
      before { get edit_post_comment_path(post, comment) }

      it 'return status code 302' do
        expect(response).to have_http_status(302)
      end
    end
  end
end
