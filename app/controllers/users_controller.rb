class UsersController < ApplicationController
  def me
    if user_signed_in?
      render json: current_user.to_json
    else
      render json: { error: 'user not authenticated' }, status: 403
    end
  end
end
