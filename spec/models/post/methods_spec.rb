# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'methods' do
    describe 'latest_posts' do
      before do
        create_list(:post, 10, user: build(:user))
      end

      let(:latest_posts) { described_class.latest_posts(4) }

      it 'returns 4 latest posts' do
        expect(latest_posts.length)
          .to eq(4)
      end

      it 'matches expected last post object' do
        expect(described_class.last).to eq(latest_posts.last)
      end
    end
  end
end
