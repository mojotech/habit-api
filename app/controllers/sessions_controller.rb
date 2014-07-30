class SessionsController < DeviseController
  respond_to :json
  skip_before_filter :authenticate_user_from_token!

  def create
    resource = User.find_for_database_authentication(email: params[:user][:email])
    return invalid_email_attempt unless resource

    if resource.valid_password?(params[:user][:password])
      sign_in "user", resource
      render :json=> {
        user_token: resource.authentication_token,
        user_email: resource.email,
        user_id: resource.id
      }, status: 201
      return
    end
    invalid_email_attempt
  end

  def destroy
    sign_out(resource_name)
    render json: { success: true, status: :ok }
  end

  protected

  def invalid_email_attempt
    render :json=> {:success=>false, :message=>"Error with your email or password"}, :status=>401
  end
end
