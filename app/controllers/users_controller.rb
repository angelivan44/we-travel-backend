class UsersController < ApplicationController
 
  def show
    @user = User.find(params[:id])

    render json: @user.as_json(include: [:followers, :following])
  end

  def create 
    user = User.new(user_params)
    if user.save
      render json: user
    else
      render json: user.errors
    end
  end

  def edit
    if current_user.update(user_params)
      render json: current_user
    else
      render json: current_user.errors
    end
  end

  def destroy
    if current_user.destroy
      render json: {message: "ok"}
    else
      render json: current_user.errors
    end
  end
  
  def user_params
    params.permit(:email, :password, :username,:name, :avatar)
  end

  
end
