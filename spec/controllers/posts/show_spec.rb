require 'rails_helper'
require_relative '../../support/shared_examples'

RSpec.describe PostsController, type: :controller do
  let(:user) { create(:user) }
  let(:user2) { create(:user) }
  let(:post) { create(:post, user: user) }

  describe 'show#GET' do
    describe 'all users' do
      before do
        get :show, params: { id: post.id }
      end

      it { is_expected.to respond_with(200) }
      it { is_expected.to render_template(:show) }
    end

    describe 'when authenticated' do
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

    describe 'when post does not exist' do
      before { get :show, params: { id: 'asd23' } }
      include_examples 'not found'
    end
  end
end
