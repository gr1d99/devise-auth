require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:post_attributes) { { post: attributes_for(:post) } }

  describe 'POST' do
    describe 'guest user' do
      before do
        post :create, params: post_attributes
      end

      it { is_expected.to redirect_to(new_user_session_url) }
    end

    describe 'logged in user' do
      let(:user) { create(:user) }

      before do
        sign_in(user)
      end

      context 'when data is valid' do
        before do
          post :create, params: post_attributes
        end

        it 'redirects to posts#new' do
          expect(response).to redirect_to(new_post_url)
        end

        it 'adds new post to database' do
          expect(Post.last.title).to eq(post_attributes[:post][:title])
          expect(Post.last.content).to eq(post_attributes[:post][:content])
        end
      end

      context 'when data is invalid' do
        before do
          post :create, params: { post: { title: Faker::Business.name } }
        end

        it 'renders new template' do
          expect(response).to render_template(:new)
        end

        it 'does not change add any post to database' do
          expect(Post.count).to be_zero
        end
      end
    end
  end
end
