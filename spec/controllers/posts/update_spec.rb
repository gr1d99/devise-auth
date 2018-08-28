require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:user) { create(:user) }
  let(:user_2) { create(:user) }
  let(:post) { create(:post, user: user) }

  describe 'update#PUT' do
    describe 'guest user' do
      before { put :update, params: { id: post.id, title: 'something' } }

      it { is_expected.to respond_with(302) }
      it { is_expected.to redirect_to(new_user_session_path) }
    end

    describe 'authenticated user and is not owner of post' do
      before do
        sign_in(user_2)
        put :update, params: { id: post.id, title: Faker::Dune.title }
      end

      it { is_expected.to respond_with(404) }
      it { is_expected.to render_template(:'not_found') }
    end

    describe 'and is owner of post' do
      let(:new_title) { 'some new title' }
      let(:new_content) { 'some new content' }
      let(:post_object) { Post.find(post.id) }
      let(:post_params) do
        {
          title: new_title,
          content: new_content
        }
      end

      before do
        sign_in(user)
        put :update, params: {
          id: post_object.id,
          post: post_params
        }
      end

      before(:each) { post_object.reload }

      it { is_expected.to respond_with(302) }
      it { is_expected.to redirect_to(post_path(post_object)) }
      it { expect(flash[:notice].to_s).to eq('Post updated successfully') }

      it 'sets new title' do
        expect(post_object.title).to eq(new_title)
      end

      it 'sets new content' do
        expect(post_object.content).to eq(new_content)
      end
    end
  end
end
