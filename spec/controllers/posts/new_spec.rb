# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:post_attributes) { attributes_for(:post) }

  describe 'guest user' do
    describe 'GET new' do
      it 'should redirect user to index page' do
        get :new
        expect(response).to redirect_to(new_user_session_url)
      end
    end
  end

  describe 'logged in user' do
    let(:user) { create(:user) }

    before do
      sign_in(user)
    end

    describe 'GET new' do
      before do
        get :new
      end

      it { is_expected.to respond_with(200) }

      it 'renders new template' do
        expect(response).to render_template(:new)
      end

      it 'assigns new post instance' do
        expect(assigns(:post)).to be_a_new(Post)
      end
    end
  end
end
