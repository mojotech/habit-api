class HabitsController < ApplicationController
  include TokenAuthentication

  before_filter :authenticate_user_from_token!
  before_filter :authenticate_user!

  def index
    if params[:title]
      habits = Habit.where(private: false).where('title ilike ?', "%#{params[:title]}%")
    elsif params[:suggestions]
      habits = Habit.where(private: false)
    else
      habits = current_user.habits
    end
    render json: habits, each_serializer: HabitSerializer
  end

  def show
    render json: current_user.habits.find(params[:id]), serializer: HabitSerializer
  end

  def create
    habit = Habit.associate_matching_or_create(habit_params, current_user)
    if habit.save
      render json: habit, status: 200
    else
      render json: habit.errors, status: 406
    end
  end

  def update
    render json: current_user.habits.find(params[:id]).convert_or_update(habit_params, current_user)
  end

  def destroy
    habit = Habit.find(params[:id])
    if habit.users.count > 1
      habit.users.delete(current_user)
      habit.checkins.where(user: current_user).destroy_all
      habit.save
    else
      habit.destroy
    end
    render json: :no_content, status: :no_content
  end

  private

  def habit_params
    params.permit(:title, :private, :id)
  end
end
