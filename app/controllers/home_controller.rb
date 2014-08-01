class HomeController < ApplicationController
  skip_before_filter :authenticate_user_from_token!
  
  def index
  end

  def send_password_reset
    user = User.where(email: params[:email])
    if user.count > 0
      user.first.send_reset_password_instructions
      render json: { user: user }, status: 200
    else
      render json: { error: "The specified account doesn't exist." }, status: 406
    end
  end
end
