class HabitsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    render json: Habit.all, each_serializer: HabitSerializer
  end

  def show
    render json: Habit.find(params[:id]), serializer: HabitSerializer
  end

  def create
    render json: Habit.create(title: habit_params)
  end

  def update
    render json: Habit.find(params[:id]).update_attributes(habit_params)
  end

  def destroy
    Habit.destroy(params[:id])
    render json: :no_content, status: :no_content
  end

  private

  def habit_params
    params.require(:habit).require(:title)
  end
end
