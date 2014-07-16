class HabitsController < ApplicationController
  before_filter :authenticate_user_from_token!
  before_filter :authenticate_user!

  def index
    render json: current_user.habits, each_serializer: HabitSerializer
  end

  def show
    render json: current_user.habits.find(params[:id]), serializer: HabitSerializer
  end

  def create
    render json: current_user.habits.create(habit_params)
  end

  def update
    render json: current_user.habits.find(params[:id]).update_attributes(habit_params)
  end

  def destroy
    Habit.destroy(params[:id])
    render json: :no_content, status: :no_content
  end

  private

  def habit_params
    {
      title: params.require(:habit).require(:title),
      unit: params.require(:habit).require(:unit)
    }
  end
end
