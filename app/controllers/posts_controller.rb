class PostsController < ApplicationController
  def index
    # @users = User.includes(posts: { comments: [:author] }).find(params[:user_id])
    # @posts = @users.posts

    @posts = Post.includes(:author, :comments, :likes).where(author_id: params[:user_id])
    @users = User.find(params[:user_id])
  end

  def show
    @users = User.find(params[:user_id])
    @post = Post.includes(:author, :comments).find(params[:id])
    @recent_comments = @post.get_recent_comments
    @likes = @post.likes
  end

  def new
    @post = Post.new
  end

  def create
    @user = current_user
    @post = @user.posts.new(author: @user, title: params[:post][:title], text: params[:post][:text])
    if @post.save
      @post.update_user_post_count
      flash[:notice] = 'Your post was created successfully'
      redirect_to posts_new_path(@user, @post)
    else
      render :new
      flash.alert = 'sorry, something went wrong!'
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
