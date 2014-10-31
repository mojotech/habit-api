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
    current_target = current_user.targets.find(params[:id])

    if conversion_params[:conversion][:type].present? && conversion_params[:conversion][:factor].present?
      current_target.convert_existing_checkins(conversion_params[:conversion][:type], conversion_params[:conversion][:factor])
    end

    render json: current_target.update_attributes(target_params)
  end

  def destroy
    render json: current_user.targets.find(params[:id]).destroy
  end

 private

  def target_params
    params
      .permit(:value, :timeframe, :unit, :private, habit_attributes: [:title])
  end

  def conversion_params
    params.permit(conversion: [:factor, :type])
  end
end
