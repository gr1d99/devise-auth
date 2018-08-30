require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the PostsHelper. For example:
#
# describe PostsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe PostsHelper, type: :helper do
  let(:user_1) { create(:user) }
  let(:user_2) { create(:user) }
  let(:post) { create(:post, user: user_1) }

  context 'when user post owner' do
    before { sign_in(user_1) }

    it 'returns true' do
      expect(helper.owner?(post)).to be_truthy
    end
  end

  context 'when user is not post owner' do
    it 'returns false' do
      expect(helper.owner?(post)).not_to be_truthy
    end
  end
end
