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
    if habit_params[:private]
      render json: current_user.habits.create(habit_params)
    else
      matching_habit = Habit.where(private: false, title: habit_params[:title]).first
      if matching_habit
        current_user.habits << matching_habit
        render json: matching_habit
      else
        render json: current_user.habits.create(habit_params)
      end
    end
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
    params.require(:habit).permit(:title, :unit, :private)
  end
end
