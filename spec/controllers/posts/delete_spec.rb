# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:user) { create(:user) }
  let(:post) { create(:post, user: user) }
  let(:user_2) { create(:user) }

  describe 'destroy#DELETE' do
    describe 'guest user' do
      before { delete :destroy, params: { id: post.id } }

      it { is_expected.to respond_with(302) }
      it { is_expected.to redirect_to(new_user_session_path) }
    end

    describe 'authenticated user' do
      context 'who is not post owner' do
        before do
          sign_in(user_2)
          delete :destroy, params: { id: post.id }
        end

        it { is_expected.to respond_with(404) }
        it { is_expected.to render_template(:not_found) }
      end

      context 'who is owner of post' do
        before do
          sign_in(user)
          delete :destroy, params: { id: post.id }
        end

        it { is_expected.to respond_with(302) }
        it { is_expected.to redirect_to(posts_path) }
        it 'renders success message' do
          expect(flash[:notice]).to match(/Post deleted successfully/)
        end
      end
    end
  end
end
