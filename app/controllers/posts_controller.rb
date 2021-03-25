class PostsController < ApplicationController
  before_action :current_post , only: %i[show , edit , destroy] 
  def index
    @posts = Post.all
    render json: @posts
  end

  def show
    render json: current_post
  end
    
  def create
    post = Post.new(post_params)
    post.user = current_user
    if post.save
      render json: post
    else
      render json: post.errors
    end

  end
   
  def edit
    if(current_post.update(post_params))
      render json: current_post
    else
      render json: current_post.errors
    end
  end

  def destroy
   if current_post.destroy
    render json: {message: "ok"}
   else
    render json: current_post.errors
   end

  end

  private 

  def post_params
    params.required(:post).permit(:title, :body, :images)
  end

  def current_post
    Post.find(params[:id])
  end
end
