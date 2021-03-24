class PostsController < ApplicationController
  def index
    @posts = Post.all
    render json: @post
  end

  def show; end

  def create; end

  def update; end

  def destroy; end

  private 

  def post_params
    params.required(:post).permit(:title, :body, :user_id)
  end
end
