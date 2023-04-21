require 'rails_helper'

RSpec.describe 'posts/show', type: :feature do
  before(:each) do
    @img = 'https://picsum.photos/id/870/200/300?grayscale&blur=2'
    @author = User.create(name: 'Dan', photo: @img, bio: 'Teacher from Mexico', posts_counter: 2)

    visit root_path

    @first_post = Post.create(author: @author, title: 'Dan Post #1', text: "This is Dan's first post", comments_counter: 0, likes_counter: 0)
    @second_post = Post.create(author: @author, title: 'Dan Post #2', text: "This is Dan's second post")

    @first_comment = Comment.create(post: @first_post, author: @author, text: 'First comment for Dan')
    @second_comment = Comment.create(post: @second_post, author: @author, text: 'Second comment for Dan')

    @first_like = Like.create(post: @first_post, author: @author)
    @second_like = Like.create(post: @first_post, author: @author)
    @third_like = Like.create(post: @first_post, author: @author)

    visit user_post_path(@first_post.author, @first_post)
  end

  it "shows the post's title" do
    expect(page).to have_content(@first_post.title)
  end

  it "shows the post's author" do
    expect(page).to have_content(@first_post.author.name)
  end

  it 'shows the number of comments on the post' do
    expect(page).to have_content('Comments: 1')
  end

  it 'shows the number of likes on the post' do
    expect(page).to have_content('Likes: 3')
  end

  it "shows the post's text" do
    expect(page).to have_content(@first_post.text)
  end

  it "shows the username of the comment's author" do
    expect(page).to have_content(@first_comment.author.name)
  end

  it "shows the comment's text" do
    expect(page).to have_content(@first_comment.text)
  end
end
