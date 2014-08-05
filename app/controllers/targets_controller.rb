class TargetsController < ApplicationController
  include TokenAuthentication

  before_filter :authenticate_user_from_token!
  before_filter :authenticate_user!

  def create
    habit = current_user.habits.find(params[:habit_id])
    render json: habit.targets.create(target_params.merge({ user_id: current_user.id }))
  end

  def update
    target = current_user
      .habits
      .find(params[:habit_id])
      .targets
      .where(user_id: params[:user_id])
      .first

    render json: target.update_attributes(target_params)
  end

 private

  def target_params
    params
      .permit(:value, :timeframe)
  end
end
