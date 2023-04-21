require 'rails_helper'
RSpec.describe 'posts/index', type: :feature do
  before :each do
    @img = 'https://picsum.photos/id/870/200/300?grayscale&blur=2'
    @author = User.create(name: 'Dan', photo: @img, bio: 'Teacher from Mexico', posts_counter: 2)
    visit root_path
    @first_post = Post.create(author: @author, title: 'Dan Post #1', text: "This is Dan's first post")
    @second_post = Post.create(author: @author, title: 'Dan Post #2', text: "This is Dan's second post")
    @first_comment = Comment.create(post: @first_post, author: @author, text: 'First comment for Dan')
    @second_comment = Comment.create(post: @second_post, author: @author, text: 'Second comment for Dan')
    @first_like = Like.create(post: @first_post, author: @author)
    @second_like = Like.create(post: @second_post, author: @author)
    visit user_posts_path(@author)
  end
  it 'shows the user\'s profile picture' do
    img = find('.image')
    expect(img[:src]).to include(@img)
  end
  it 'displays the user\'s name' do
    expect(page).to have_content(@author.name)
  end
end
