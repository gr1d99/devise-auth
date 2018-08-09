class Post < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :title, uniqueness: {
    scope: :user_id,
    message: 'You can\'t have more than one post with the same title'
  }
  validates :description, presence: true
  validates :user, presence: true
end
