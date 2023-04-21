require 'rails_helper'

RSpec.describe 'users/index', type: :feature do
  before(:each) do
    @users = [
      User.create(
        name: 'Tom',
        photo: 'https://picsum.photos/id/870/200/300?grayscale&blur=2',
        bio: 'Chef from Italy',
        posts_counter: 2
      ),
      User.create(
        name: 'Jerry',
        photo: 'https://picsum.photos/id/870/200/300?grayscale&blur=2',
        bio: 'Computer Programmer', posts_counter: 3
      )
    ]

    @first_user = User.first

    @post1 = Post.create(author: @first_user, title: 'Post It', text: 'Post 1',
                         comments_counter: 2, likes_counter: 6)
    @post2 = Post.create(author: @first_user, title: 'Another random post',
                         text: 'Some post', comments_counter: 0, likes_counter: 3)
    @post3 = Post.create(author: @first_user, title: 'Post 3', text: 'A new post', comments_counter: 4,
                         likes_counter: 1)

    visit user_path(@first_user)
  end

  it "shows the user's profile picture" do
    img = page.all('img')
    expect(img.size).to eq(1)
  end

  it 'shows the users name' do
    expect(page).to have_content(@first_user.name)
  end

  it 'shows the number of post the user has written' do
    expect(page).to have_content(@first_user.posts_counter)
  end

  it 'shows the users bio' do
    expect(page).to have_content(@first_user.bio)
  end

  it 'shows the users first three posts' do
    expect(page).to have_content(@post1.title)
    expect(page).to have_content(@post2.title)
    expect(page).to have_content(@post3.title)
  end

  it 'shows a button to view all users posts' do
    expect(page).to have_content('See all posts')
  end

  it 'redirects to the posts show page when I click on a user' do
    visit user_posts_path(@first_user)
    click_link @post3.title
    expect(current_path).to match user_posts_path(@first_user.id)
  end

  it 'redirects to the posts show page when I click on a user' do
    click_link 'See all posts'
    expect(current_path).to match user_posts_path(@first_user)
  end
end