require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:user) { create(:user) }
  let(:user_2) { create(:user) }
  let(:post) { create(:post, user: user) }

  def make_request
    get :edit, params: { id: post.id }
  end

  describe 'edit#GET' do
    describe 'guest user' do
      before { make_request }

      it { is_expected.to respond_with(302) }
      it { is_expected.to redirect_to(new_user_session_path) }
    end

    describe 'authenticated user who is not owner of post' do
      before do
        sign_in(user_2)
        make_request
      end

      it { is_expected.to respond_with(404) }
      it { is_expected.to render_template(:not_found) }
    end

    describe 'authenticated user ' do
      before do
        sign_in(user)
        make_request
      end

      it { is_expected.to respond_with(200) }
      it { is_expected.to render_template(:edit) }
      it 'assigns post object' do
        expect(assigns(:post)).to eq(post)
      end
    end
  end
end
