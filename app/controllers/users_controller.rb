class UsersController < ApplicationController

  def authenticated_user
    if user_signed_in?
      render json: current_user
    else
      render json: { error: 'user not authenticated' }, status: 403
    end
  end
end
