# class CommentsController < ApplicationController
#   # load_and_authorize_resource

#   def create
#     @comment = current_user.comments.new(comment_params)
#     @post = Post.find(params[:post_id])
#     @comment.post_id = @post.id
#     @comment.save
#     flash[:success] = 'Commented!'
#     redirect_to "/users/#{current_user.id}/posts"
#   end

#   private

#   def comment_params
#     params.permit(:text)
#   end
# end

class CommentsController < ApplicationController
  before_action :set_post, only: [:create]

  def new
    @post = Post.find(params[:post_id])
    @comments = @post.comments
    @comment = Comment.new
    @post = Post.find(params[:post_id])
  end

  # def create
  #   @user = current_user
  #   @post = Post.find(params[:post_id])
  #   @comment = Comment.new(author: @user, post: @post, text: params[:comment][:text])
  #   return unless @comment.save

  #   redirect_to user_posts_path(@post.author)
  # end

  def create
    @user = current_user
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.author = @user
    
    if @comment.save
      redirect_to user_posts_path(@post.author)
    else
      # Handle the error
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @user = @post.author.id
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to user_posts_path(@user), notice: 'Comment was successfully deleted.'
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.permit(:text)
  end

  def on_comment_create_success
    flash[:notice] = 'Comment added successfully!'
    @comment.update_comments_counter
    redirect_to user_post_path(user_id: params[:user_id], id: params[:post_id])
  end

  def on_comment_create_failure
    flash[:alert] = "Couldn't add Comment!"
    render :new, status: :unprocessable_entity
  end
end
