require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:user) { create(:user) }
  let(:user2) { create(:user) }
  let(:post) { create(:post, user: user) }

  describe 'GET' do
    describe 'guest user' do
      before do
        get :show, params: { id: post.id }
      end

      it { is_expected.to respond_with(302) }
      it { is_expected.to redirect_to(new_user_session_path) }
    end

    describe 'when authenticated' do
      describe 'when user has no post' do
        before do
          sign_in(user2)
          get :show, params: { id: post.id }
        end

        it { is_expected.to respond_with(404) }
      end

      describe 'when user has post' do
        before do
          sign_in(user)
          get :show, params: { id: post.id }
        end

        it { is_expected.to respond_with(200) }
        it { is_expected.to render_template(:show) }
        it 'assigns post instance to template' do
          expect(assigns(:post)).not_to be nil
        end
      end
    end
  end
end
