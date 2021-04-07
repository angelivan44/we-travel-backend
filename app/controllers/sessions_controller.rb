class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:create , :sendemail ]
  def create
    user = User.valid_login?(params[:email], params[:password])
    if user
      user.regenerate_token
      render json: user.as_json(include: [ :comments, :likes] , methods: [:avatar_url , :cover_url , :followers_data , :following_data, :posts_data])
    else
      render json: {message: "email or password incorrect"} , status: :unauthorized
    end

  end

  def destroy
    current_user.invalidate_token
    render json: {message: "ok"}
  end

  def sendemail
        # Tell the UserMailer to send a welcome email after save
    UserMailer.welcome_email("angelhuayas@gmail.com").deliver_now
        
    render json: {message:"creado"}

  end
end
