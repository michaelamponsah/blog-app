require 'rails_helper'

RSpec.describe Like, type: :model do
  before do
    @user = User.create(name: 'John Doe', photo: 'photo url', bio: 'Awesome bio', posts_counter: 0)
    @post = Post.create(title: 'Awesome Post', text: 'Post body', author: @user, comments_counter: 0, likes_counter: 0)
  end

  describe 'update_post_likes_counter' do
    it 'should update post likes_counter after creating a new Like' do
      expect(@post.likes_counter).to eq(0)
      Like.create(author: @user, post: @post)
      expect(@post.reload.likes_counter).to eq(1)
    end
  end
end
