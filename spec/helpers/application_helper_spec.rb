# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  let(:users) { create_list(:user, 2) }
  let(:post) { create(:post, user: users.first) }
  let(:comment) { create(:comment, commentable: post, user: users.last) }

  describe '.owner?' do
    context 'when user is owner' do
      before { sign_in(users.last) }

      it 'returns true' do
        expect(helper.owner?(comment)).to be_truthy
      end
    end

    context 'when user is not owner' do
      before { sign_in(users.first) }

      it 'returns false' do
        expect(helper.owner?(comment)).to be_falsey
      end
    end

    context 'when first argument is not an instance of comment' do
      it 'returns false in-case instance does not have attribute user' do
        invalid_object = double('Invalid')
        expect(helper.owner?(invalid_object))
      end
    end
  end
end
