# frozen_string_literal: true

require 'rails_helper'
require_relative '../../support/shared_examples'

RSpec.describe HomeController do
  before do
    create_list(
      :post, 10,
      user: build(:user)
    )

    get :index
  end

  describe 'index#GET' do
    let(:latest_posts) { Post.latest_posts(4) }
    it 'assigns latest posts' do
      expect(assigns[:latest_posts]).to match_array(latest_posts)
    end

    it 'assigns latest 4 posts' do
      expect(assigns[:latest_posts].length).to eq(4)
    end

    it 'assignes exactly expected post objects' do
      expect(assigns[:latest_posts].last).to eq(Post.last)
    end

    it_behaves_like 'index examples'
  end
end
