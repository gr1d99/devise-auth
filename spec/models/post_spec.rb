require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:first_user) { create(:user) }
  let(:second_user) { create(:user) }
  let(:title) { Faker::Book.title }
  let(:first_post) { build(:post, title: title, user: first_user) }
  let(:second_post) { build(:post, title: title, user: second_user) }

  describe 'validation' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:content) }
    it { should validate_presence_of(:user) }
    it { should validate_uniqueness_of(:title).scoped_to(:user_id).with_message('You can\'t have more than one post with the same title') }
    it 'should allow different users to have posts with same titles' do
      first_post.save
      expect(second_post.valid?).to be_truthy
    end
  end

  describe 'association' do
    it { is_expected.to belong_to(:user) }
  end
end
