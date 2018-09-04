# frozen_string_literal: true

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

    it 'assigns posts' do
      expect(assigns(:posts)).to match_array(Post.send(:all))
    end
    it_behaves_like 'index examples'
  end
end
