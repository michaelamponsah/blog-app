class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes
  after_save :update_user_post_count

  def update_user_post_count
    author.update(posts_count: Post.where(author_id).count)
  end

  private

  def get_recent_comments(limit_count = 5)
    comments.order(created_at: :desc).limit(limit_count)
  end
end
