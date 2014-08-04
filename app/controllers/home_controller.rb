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

  def change_password
    reset_password_token = Devise.token_generator.digest(User, :reset_password_token, params[:reset_password_token])
    if User.where(reset_password_token: reset_password_token).count == 0
      render json: { errors: ['Invalid reset password token.'] }, status: 403
      return
    else
      errors = []
      password = params[:password]
      password_confirmation = params[:password_confirmation]
      errors << "Passwords do not match." if password != password_confirmation
      errors << "Passwords must be 8 characters or longer." if password.length < 8

      if errors.count > 0
        render json: { errors: errors }, status: 403
      else
        user = User.where(reset_password_token: reset_password_token).first
        user.reset_password!(params[:password], params[:password_confirmation])
        render json: { user: user }, status: 200
      end
    end
  end
end
