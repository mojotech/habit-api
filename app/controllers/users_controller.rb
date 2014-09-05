class UsersController < ApplicationController
  def me
    if request.patch?
      current_user.display_name = params[:display_name]
      if current_user.save
        render json: current_user, status: 200
      else
        render json: current_user.errors, status: 406
      end
    else
      if user_signed_in?
        render json: current_user
      else
        render json: { error: 'user not authenticated' }
      end
    end
  end
end
