class SessionsController < ApplicationController
  skip_before_action :require_login, only: :create
  def create
    user = User.valid_login?(params[:email], params[:password])
    if user 
      user.regenerate_token
      render json: user.as_json(include: [:followers, :following, :posts , :comments, :likes ], methods: :service_url)
    end

  end

  def destroy
    current_user.invalidate_token
    render json: {message: "ok"}
  end
end
