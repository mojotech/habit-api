class CheckinsController < ApplicationController
  include TokenAuthentication

  before_filter :authenticate_user_from_token!
  before_filter :authenticate_user!

  def create
    habit = current_user.habits.find(params[:habit_id])
    checkin = habit.checkins.new(checkin_params.merge({ user_id: current_user.id }))
    checkin.target = current_user.targets.find_by(habit_id: habit.id)
    if checkin.save
      render json: checkin, status: 200
    else
      render json: { errors: checkin.errors }, status: 406
    end
  end

  def index
    habit = current_user.habits.find(params[:habit_id])

    render json: habit.checkins.includes(:user)
  end

  def destroy
    render json: Checkin.find(params[:id]).destroy
  end

  private

  def checkin_params
    params
      .permit(:value, :habit_id, :note)
  end
end
