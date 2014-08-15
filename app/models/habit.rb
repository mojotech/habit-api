class Habit < ActiveRecord::Base
  before_destroy :confirm_not_shared
  before_save :add_past_tense
  before_save :update_user_count
  has_and_belongs_to_many :users
  has_many :checkins, order: "created_at DESC", dependent: :destroy
  has_many :targets, dependent: :destroy

  validates :title, presence: true
  validates_inclusion_of :private, in: [true, false]
  validates_uniqueness_of :title, conditions: -> { where({ private: false})  }, if: :public?

  def self.associate_matching_or_create(habit_params, current_user)
    associate_matching(habit_params, current_user) do |match|
      if match
        match
      else
        current_user.habits.create(title: habit_params[:title], private: habit_params[:private])
      end
    end
  end

  def convert_or_update(habit_params, current_user)
    attrs = {
      title: attributes['title'],
      private: attributes['private']
    }.merge(habit_params.symbolize_keys)
    attrs[:private] = (attrs[:private] == 'true' or attrs[:private] == true)
    if will_be_private(attrs)
      return convert_to_private attrs, current_user
    elsif will_be_public(attrs)
      return convert_to_public attrs, current_user
    else
      update_attributes attrs
    end

    self
  end

  def public?
    !private?
  end

  def shared?
    public? && users.count >= 2
  end

  private

  def update_user_count
    self.user_count = users.count
  end

  def add_past_tense
    if title_changed?
      self.past_tense = past_tense_title_verb
    end
  end

  def title_verb
    t = EngTagger.new
    tagged = t.add_tags "I " + title.downcase
    infinitive_verbs = t.get_infinitive_verbs tagged
    if infinitive_verbs.first
      infinitive_verbs.first.first
    elsif (base_verbs = t.get_base_present_verbs(tagged)).first
      base_verbs.first.first
    else
      nil
    end
  end

  def past_tense_title_verb
    if title_verb
      title_verb.verb.conjugate(tense: :present, aspect: :perfect, person: :second).downcase
    else
      nil
    end
  end

  def convert_to_public(habit_params, current_user)
    associate_matching_or_update habit_params, current_user
  end

  def convert_to_private(habit_params, current_user)
    private_habit = Habit.associate_matching_or_create(habit_params, current_user)
    checkins.where(user_id: current_user.id).each do |checkin|
      checkin.habit = private_habit
      checkin.save!
    end
    targets.where(user_id: current_user.id).each do |target|
      target.habit = private_habit
      target.update_completion
      target.save!
    end
    users.destroy current_user
    destroy if users.count == 0
    private_habit
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
        match
      else
        update_attribute :private, habit_params[:private]
      end
    end
  end

  def self.associate_matching(habit_params, current_user, &block)
    matching_habit = Habit.where(private: habit_params[:private], title: habit_params[:title]).first
    if matching_habit and !matching_habit.users.include?(current_user)
      Target.where(user_id: current_user.id, habit_id: habit_params[:id]).each do |target|
        target.habit = matching_habit
        target.update_completion
        target.save!
      end
      Checkin.where(user_id: current_user.id, habit_id: habit_params[:id]).each do |checkin|
        checkin.habit = matching_habit
        checkin.save!
      end
      current_user.habits << matching_habit
    end
    yield(matching_habit)
  end

  def confirm_not_shared
    !shared?
  end
end
