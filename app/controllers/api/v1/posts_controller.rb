require 'jwt'

class Api::V1::PostsController < Api::V1::ApplicationController
  skip_before_action :authenticate_user!

  def index
    user = User.find(params[:user_id])
    posts = user.posts
    render json: posts
  end
end
