class CheckinsController < ApplicationController
  include TokenAuthentication

  before_filter :authenticate_user_from_token!
  before_filter :authenticate_user!

  def create
    habit = current_user.habits.find(params[:habit_id])

    render json: habit.checkins.create(checkin_params.merge({ user_id: current_user.id }))
  end

  def index
    habit = current_user.habits.find(params[:habit_id])

    render json: habit.checkins.includes(:user)
  end

  private

  def checkin_params
    params
      .permit(:value, :habit_id, :note)
  end
end
