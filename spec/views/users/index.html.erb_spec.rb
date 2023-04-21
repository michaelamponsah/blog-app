require 'rails_helper'

RSpec.describe 'users/index', type: :feature do
  before(:each) do
    @users = [
      User.create(
        name: 'Tom',
        photo: 'https://picsum.photos/id/870/200/300?grayscale&blur=2',
        bio: 'Software Developer from Nigeria',
        posts_counter: 2
      ),
      User.create(
        name: 'Jerry',
        photo: 'https://picsum.photos/id/870/200/300?grayscale&blur=2',
        bio: 'Software Developer from South Africa', posts_counter: 3
      )
    ]
    visit users_path
  end

  it 'shows the name of all users' do
    @users.each do |user|
      expect(page).to have_content(user.name)
    end
  end

  it 'display the profile picture for each user' do
    @users.each do |user|
      expect(page).to have_css("img[src='#{user.photo}']")
    end
  end

  it 'displays number of posts each user has written' do
    @users.each do |user|
      expect(page).to have_content "Number of posts: #{user.posts_counter}"
    end
  end

  it 'redirects to to a users show page when a user is clicked' do
    click_on @users.first.name
    expect(page).to have_current_path user_path(@users.first.id)
  end
end
