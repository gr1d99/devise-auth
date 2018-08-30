require 'rails_helper'
require_relative '../../support/shared_examples'

RSpec.describe PostsController, type: :controller do
  let(:user) { create(:user) }
  let(:user2) { create(:user) }
  let!(:post_1) { create(:post, user: user2) }
  let!(:post_2) { create(:post, user: user) }
  let(:posts) { Post.all }

  describe 'index#GET' do
    before { get :index }
    include_examples 'index examples', :posts, Post
  end
end
