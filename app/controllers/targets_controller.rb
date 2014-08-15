class TargetsController < ApplicationController
  include TokenAuthentication

  before_filter :authenticate_user_from_token!
  before_filter :authenticate_user!

  def create
    habit = current_user.habits.find(params[:habit_id])
    target = habit.targets.new(target_params.merge({ user_id: current_user.id }))
    if target.save
      render json: target.to_json, status: 200
    else
      render json: target.errors, status: 406
    end
  end

  def index
    habit = current_user.habits.find(params[:habit_id])
    render json: habit.targets
  end

  def show
    habit = current_user.habits.find(params[:habit_id])
    render json: habit.targets.where(user_id: current_user.id).first
  end

  def update
    target = current_user
      .habits
      .find(params[:habit_id])
      .targets
      .first

    render json: target.update_attributes(target_params)
  end

 private

  def target_params
    params
      .permit(:value, :timeframe, :unit)
  end
end
