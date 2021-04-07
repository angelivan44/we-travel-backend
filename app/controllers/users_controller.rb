class UsersController < ApplicationController
  skip_before_action :require_login, only: [:create , :show, :valid, :index, :otp_validation] 
  include Pundit
  def index
    users = User.all
    orderDAta = users.sort_by{|user| -user.followers.length}
    mostPopularUsers = orderDAta.slice(0,3)
    render json: mostPopularUsers.map{|user| user.as_json(methods: :avatar_url)}
  end
  def show
    user = User.find(params[:id])
    render json: user.as_json(include: [ :comments, :likes] , methods: [:avatar_url , :cover_url , :followers_data , :following_data, :posts_data])
  end

  def create 
    user = User.new(user_params)
    if user.save
      UserMailer.welcome_email(user.email , user.otp_code).deliver_now
      render json: user.as_json(include: [:followers, :following, :posts , :comments, :likes] , methods: [:avatar_url , :cover_url])
    else
      render json: user.errors , status: :unprocessable_entity
    end
  end

  def valid
    user = User.new(user_params)
    if user.save
      code = user.otp_code
      p code
      render json: { message: "ok" , id: user.id}
    else
      render json: user.errors
    end
  end

  def otp_validation
    user = User.find(params[:id])
    code = params[:pin]
    if user.authenticate_otp(code , drift: 120)
      render json: {message: "ok"}
    else
      render json: {message: "pin incorrect"}
    end
  end

  def update
    authorize current_user
    if params[:following_id]
      following = User.find(params[:following_id])
      statusFollowing = current_user.following.find{ |user| user.id == following.id}
      
      if statusFollowing
        filterFollings = current_user.following.filter {|user| user.id != statusFollowing.id}
        current_user.following = filterFollings
      else
        current_user.following.push(following)
      end
      if current_user.save
        render json: current_user.as_json(include: [ :comments, :likes] , methods: [:avatar_url , :cover_url , :followers_data , :following_data, :posts_data])
      else
        render json: current_user.errors , status: :unprocessable_entity
      end
    else 
      if current_user.update(user_params)
      render json: current_user.as_json(include: [ :comments, :likes] , methods: [:avatar_url , :cover_url , :followers_data , :following_data, :posts_data])
      else
      render json: current_user.errors , status: :unprocessable_entity
      end
    end
  end

  def destroy
    authorize current_user
    if current_user.destroy
      render json: {message: "ok"}
    else
      render json: current_user.errors
    end
  end
  
  def user_params
    params.permit(:email, :password, :username,:name, :avatar , :cover)
  end
end
