require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @user = User.create(name: 'John Doe', photo: 'photo url', bio: 'Awesome bio', posts_counter: 0)
    @post = Post.create(title: 'Awesome Post', text: 'Post body', author: @user, comments_counter: 0, likes_counter: 0)
  end

  describe 'update_post_comments_counter' do
    it 'should update the comments_counter attribute of the associated post' do
      expect(@post.comments_counter).to eq(0)
      Comment.create(author: @user, post: @post)
      expect(@post.comments_counter).to eq(1)
      Comment.create(author: @user, post: @post)
      expect(@post.comments_counter).to eq(2)
    end
  end

  it 'have correct user' do
    @comment = Comment.create(post: @post, author: @user)
    expect(@comment.author_id).to eq(@user.id)
  end
end
