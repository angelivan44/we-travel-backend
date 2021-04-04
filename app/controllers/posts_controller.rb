class PostsController < ApplicationController
  before_action :current_post , only: %i[show , update , destroy]
  skip_before_action :require_login, only: %i[index , show]
  include Pundit
  def index
    posts = Post.all
    min = posts.length
    min <= 3 ? slic = min : slic = 3 
    popularPosts = posts.sort_by{ |post| -post.likes_count}.slice(0,slic)
    newPosts = posts.slice(-slic,slic)
    renderPopular = popularPosts.map{ |post| post.as_json(methods: :service_url , include: {user: {methods: :avatar_url}})}
    renderNewPost = newPosts.map{ |post| post.as_json(methods: :service_url , include: {user: {methods: :avatar_url}})}
    render json: {populars: renderPopular, new: renderNewPost}
  end

  def show
    render json: current_post.as_json(methods: [:service_url, :comments_data], include: [:likes , {user: {methods: :avatar_url}}])
  end
    
  def create 
    
    post = Post.new(post_params)
    department = Department.find(params[:department_id])
    post.department = department
    imagesData= [params[:cover], params[:main], params[:last]]
    post.images = imagesData
    post.user = current_user
    if post.save
      render json: post.as_json(methods: :service_url, include: [:likes, :comments, :user])
    else
      render json: post.errors , status: :unprocessable_entity
    end

  end
   
  def update
    authorize current_post
    params[:cover] || current_post.images[0] = params[:cover]
    params[:main] || current_post.images[1] = params[:main]
    params[:last] || current_post.images[2] = params[:last]
    if(current_post.update(post_params))
      render json: current_post.as_json(include: [:likes, :comments, :user])
    else
      render json: current_post.errors , status: :unprocessable_entity
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
    params.permit(:title, :body, :location )
  end

  def current_post
    Post.find(params[:id])
  end
end
