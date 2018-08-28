require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe 'guest user' do
    before do
      get :index
    end

    it { is_expected.to respond_with(302) }
  end

  describe 'authenticated user' do
    let(:user) { create(:user) }
    let(:user2) { create(:user) }

    before do
      sign_in(user)
      get :index
    end

    context 'when user has posts' do
      let(:post_1) { create(:post, user: user2) }
      let(:post_2) { create(:post, user: user) }

      it { is_expected.to respond_with(200) }
      it { is_expected.to render_template(:index) }
      it 'assigns posts that belong to user only to the template' do
        expect(assigns(:posts)).to match_array([post_2])
        expect(assigns(:posts)).not_to match_array([post_1])
      end
    end

    context 'when user has no posts' do
      it { is_expected.to respond_with(200) }
      it 'assigns an empty posts array to template' do
        expect(assigns(:posts)).to match_array([])
      end
    end
  end
end
