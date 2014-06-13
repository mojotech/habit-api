class CheckinsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create
    render json: Checkin.create(post_params)
  end

  private

  def post_params
    params
      .require(:checkin)
      .permit(:value, :habit_id)
  end
end
