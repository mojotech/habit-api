class HabitsController < ApplicationController
  include TokenAuthentication

  before_filter :authenticate_user_from_token!
  before_filter :authenticate_user!

  def index
    if params[:title]
      habits = Habit.public
        .where('title ilike ?', "%#{params[:title]}%")
      habits = habits - current_user.habits
    elsif params[:suggestions]
      habits = Habit.public - current_user.habits
    elsif params[:user_id]
      habits = User.find(params[:user_id])
        .habits
        .public
    else
      habits = current_user.habits
    end
    render json: habits, each_serializer: HabitSerializer
  end

  def show
    render json: current_user.habits.find(params[:id]), serializer: HabitSerializer
  end

  def create
    habit = current_user.habits.create(habit_params)
    if habit.save
      render json: habit, status: 200
    else
      render json: habit.errors, status: 406
    end
  end

  def update
    render json: Habit.find(params[:id]).update_attributes(habit_params)
  end

  private

  def habit_params
    params.permit(:title, :id)
  end
end
