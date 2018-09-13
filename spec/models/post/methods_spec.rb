# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'methods' do
    before do
      create_list(:post, 10, user: build(:user))
    end

    describe 'latest_posts' do
      let(:latest_posts) { described_class.latest_posts(4) }

      it 'returns 4 latest posts' do
        expect(latest_posts.length)
          .to eq(4)
      end

      it 'matches expected last post object' do
        expect(described_class.last).to eq(latest_posts.last)
      end
    end

    describe 'search' do
      context 'when queried key matches' do
        let(:query_key) { Post.first.title[0, -3] }

        it 'returns array of posts' do
          expect(described_class.search(query_key).length).not_to be(0)
        end
      end

      context 'when queried key does not exist' do
        it 'returns an empty array' do
          expect(described_class.search('fdsfghjksfsgvbhjn').length).to be(0)
        end
      end
    end
  end
end
