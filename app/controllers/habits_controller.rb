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
    render json: Habit.associate_matching_or_create(habit_params, current_user)
  end

  def update
    render json: current_user.habits.find(params[:id]).convert_or_update(habit_params, current_user)
  end

  def destroy
    Habit.destroy(params[:id])
    render json: :no_content, status: :no_content
  end

  private

  def habit_params
    params.require(:habit).permit(:title, :unit, :private)
  end
end
