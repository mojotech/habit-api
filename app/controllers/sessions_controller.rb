class SessionsController < Devise::SessionsController
  respond_to :json
  skip_before_filter :authenticate_user_from_token!

end
