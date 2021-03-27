class UsersController < ApplicationController
  skip_before_action :require_login, only: :create
  include Pundit
  
  def show
    
    user = User.find(params[:id])
    render json: user.as_json(include: [:followers, :following, :posts , :comments, :likes] , methods: :service_url)
  end

  def create 
    user = User.new(user_params)
    if user.save
      render json: user.as_json(include: [:followers, :following, :posts , :comments, :likes] , methods: [:avatar_url , :cover_url])
    else
      render json: user.errors
    end
  end

  def update
    authorize current_user
    if current_user.update(user_params)
      render json: current_user.as_json(include: [:followers, :following, :posts , :comments, :likes] , methods: [:avatar_url , :cover_url])
    else
      render json: current_user.errors
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
