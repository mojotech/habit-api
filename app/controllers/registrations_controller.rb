class RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    user = User.new(user_params)
    user.display_name = user.email
    if user.save
      render json: user.as_json(user_token: user.authentication_token, email: user.email), status: :created
    else
      warden.custom_failure!
      render json: user.errors, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
