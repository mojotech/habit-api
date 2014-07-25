class SessionsController < DeviseController
  respond_to :json
  skip_before_filter :authenticate_user_from_token!
  # prepend_before_filter :require_no_authentication, :only => [:create ]
  # include Devise::Controllers::InternalHelpers

  # before_filter :ensure_params_exist


  def create
    resource = User.find_for_database_authentication(email:params[:user][:email])
    return invalid_email_attempt unless resource

    if resource.valid_password?(params[:user][:password])
      sign_in('user', resource)
      render json: { user_token:resource.authentication_token, user_email:resource.email, user_id: resource.id }, status: 201
      return
    end
    invalid_email_attempt
  end

  def destroy
    sign_out(resource_name)
    render json: { success: true, status: :ok }
  end

  protected
  def ensure_params_exist
    return unless params[:user].blank?
    render json:{success:false, message:'missing user parameter'}, status:422
  end

  def invalid_email_attempt
    # warden.custom_failure!
    render json: {success:false, message:'Error with your email or password'}, status:401
  end
end
