# class PostsController < ApplicationController

#   def index
#     @posts = Post.includes(:author, :comments, :likes).where(author_id: params[:user_id])
#     @users = User.find(params[:user_id])
#   end

#   def show
#     @users = User.find(params[:user_id])
#     @post = Post.includes(:author, :comments).find(params[:id])
#     @recent_comments = @post.get_recent_comments
#     @likes = @post.likes
#   end

#   def new
#     @post = Post.new
#   end

#   def create
#     @user = current_user
#     @post = @user.posts.new(author: @user, title: params[:post][:title], text: params[:post][:text])
#     if @post.save
#       @post.update_user_post_count
#       flash[:notice] = 'Your post was created successfully'
#       redirect_to posts_new_path(@user, @post)
#     else
#       render :new
#       flash.alert = 'sorry, something went wrong!'
#     end
#   end

#   private

#   def post_params
#     params.require(:post).permit(:title, :text)
#   end
# end

class PostsController < ApplicationController
  before_action :set_user, only: %i[new create edit update destroy]
  def index
    @user = User.find(params[:user_id])
    @user_posts = Post.includes(:comments).where(author_id: @user.id)
    @user_comments = Comment.where(user_id: @user.id)
    @post_comments = Comment.includes(:user).where(post_id: @user_posts.ids)
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.author
    @post_comments = Comment.includes(:author).where(post_id: @post)
  end

  def new
    @user = current_user
    @post = Post.new
  end

  def create
    @user = current_user
    @post = @user.posts.new(post_params)
    @post.comments_counter = 0
    @post.likes_counter = 0
    if @post.save
      @post.update_post_counter
      redirect_to user_path(@user)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @post = @user.posts.find(params[:id])
    @post.destroy
    redirect_to user_path(@user), notice: 'Post was successfully deleted.'
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end

  def set_user
    @user = User.find(params[:user_id])
  end
end
