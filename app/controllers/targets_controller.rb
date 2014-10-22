class TargetsController < ApplicationController
  include TokenAuthentication

  before_filter :authenticate_user_from_token!
  before_filter :authenticate_user!

  def create
    target = current_user.targets.new(target_params)

    if target.save
      render json: target, status: :ok
    else
      render json: target.errors, status: 406
    end
  end

  def show
    render json: current_user.targets.where({ habit_id: params[:habit_id]}).first
  end

  def update
    render json: current_user.targets.find(params[:id]).update_attributes(target_params)
  end

  def destroy
    render json: current_user.targets.find(params[:id]).destroy
  end

 private

  def target_params
    params
      .permit(:value, :timeframe, :unit, :private, habit_attributes: [:title])
  end
end
