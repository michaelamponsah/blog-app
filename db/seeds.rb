# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

first_user = User.create(name: 'Tom', photo: 'https://picsum.photos/200', bio: 'Teacher from Mexico.', posts_counter: 0)
second_user = User.create(name: 'Lilly', photo: 'https://picsum.photos/100', bio: 'Teacher from Poland.', posts_counter: 0)

first_post = Post.create(title: 'Hello', text: 'This is my first post', comments_counter: 0, author_id: first_user,  likes_counter: 0)

Comment.create(text: 'Hi Tom!', author_id: second_user, post: first_post)