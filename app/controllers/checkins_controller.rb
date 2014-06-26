class CheckinsController < ApplicationController
  before_filter :authenticate_user_from_token!
  before_filter :authenticate_user!

  def create
    habit = current_user.habits.find(params[:checkin][:habit_id])

    render json: habit.checkins.create(post_params)
  end

  private

  def post_params
    params
      .require(:checkin)
      .permit(:value, :habit_id)
  end
end
