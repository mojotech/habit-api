class Habit < ActiveRecord::Base

  has_and_belongs_to_many :users
  has_many :checkins, order: "created_at DESC"

  validates :title, :unit,  presence: true
  validates_inclusion_of :private, in: [true, false]
  validates_uniqueness_of :title, conditions: -> { where({ private: false})  }, if: :public?

  def self.associate_matching_or_create(habit_params, current_user)
    associate_matching(habit_params, current_user) do |match|
      if match
        match
      else
        current_user.habits.create(habit_params)
      end
    end
  end

  def convert_or_update(habit_params, current_user)
    attrs = {
      title: attributes['title'],
      unit: attributes['unit'],
      private: attributes['private']
    }.merge(habit_params)

    if will_be_private(attrs)
      convert_to_private attrs, current_user
    elsif will_be_public(attrs)
      convert_to_public attrs, current_user
    else
      update_attributes attrs
    end

    self
  end

  def public?
    !private?
  end

  def shared?
    public? && users.count >= 1
  end

  private

  def convert_to_public(habit_params, current_user)
    associate_matching_or_update habit_params, current_user
  end

  def convert_to_private(habit_params, current_user)
    private_habit = Habit.associate_matching_or_create(habit_params, current_user)
    checkins.where(user_id: current_user.id).each do |checkin|
      checkin.habit = private_habit
      checkin.save!
    end
    users.destroy current_user
  end

  def will_be_private(habit_params)
    public? and habit_params[:private] == true
  end

  def will_be_public(habit_params)
    private? and habit_params[:private] == false
  end

  def associate_matching_or_update(habit_params, current_user)
    Habit.associate_matching(habit_params, current_user) do |match|
      if match
        users.destroy current_user
      else
        update_attributes(habit_params)
      end
    end
  end

  def self.associate_matching(habit_params, current_user, &block)
    matching_habit = Habit.where(private: habit_params[:private], title: habit_params[:title]).first
    if matching_habit and !matching_habit.users.include?(current_user)
      current_user.habits << matching_habit
    end
    yield(matching_habit)
  end
end
