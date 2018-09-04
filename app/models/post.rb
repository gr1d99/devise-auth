class Post < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :title, uniqueness: {
    scope: :user_id,
    message: 'You can\'t have more than one post with the same title'
  }
  validates :content, presence: true
  validates :user, presence: true

  def self.latest_posts(number)
    order(
      created_at: :asc
    ).from(
      all.reverse_order.limit(number),
      'posts'
    )
  end
end
