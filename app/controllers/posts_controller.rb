class PostsController < ApplicationController
  before_action :current_post , only: %i[show , update , destroy]
  skip_before_action :require_login, only: %i[index , show]
  include Pundit
  def index
    posts = Post.all
    render json: posts.map{|post| post.as_json(methods: :service_url , include: {user: {methods: :avatar_url}})}
  end

  def show
    render json: current_post.as_json(methods: :service_url, include: [:likes, :comments , {user: {methods: :avatar_url}}])
  end
    
  def create 
    
    post = Post.new(post_params)
    department = Department.find(params[:department_id])
    post.department = department
    imagesData = [params[:cover], params[:main], params[:last]]
    post.images = imagesData
    post.user = current_user
    if post.save
      render json: post.as_json(methods: :service_url, include: [:likes, :comments, :user])
    else
      render json: post.errors
    end

  end
   
  def update
    authorize current_post
    if(current_post.update(post_params))
      render json: current_post.as_json(include: [:likes, :comments, :user])
    else
      render json: current_post.errors
    end
  end

  def destroy
    authorize current_post
   if current_post.destroy
    render json: {message: "ok"}
   else
    render json: current_post.errors
   end

  end

  private 

  def post_params
    params.permit(:title, :body )
  end

  def current_post
    Post.find(params[:id])
  end
end
