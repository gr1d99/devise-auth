# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  before do
    create_list(:post, 5, user: create(:user))
  end

  describe 'GET#search' do
    context 'when searched post exists' do
      let(:query_keyword) { Post.first.title[0..-3] }

      before { get :search, params: { query: query_keyword } }

      it { is_expected.to respond_with(200) }
      it { is_expected.to render_template(:search) }

      it 'returns queried keyword' do
        expect(assigns(:results)).to eq(Post.search(query_keyword))
      end
    end

    context 'when searched post does not exist' do
      before { get :search, params: { query: 'aaaaaa' } }

      it 'assigns results to an empty array' do
        expect(assigns(:results)).to match_array([])
      end
    end

    context 'when user submits an empty query' do
      before { get :search, params: { query: '' } }

      it 'assigns results to an empty array' do
        expect(assigns(:results)).to match_array([])
      end
    end
  end
end
