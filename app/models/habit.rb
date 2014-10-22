class Habit < ActiveRecord::Base

  default_scope order('user_count DESC')

  before_save :add_past_tense

  has_many :checkins, order: "created_at DESC", dependent: :destroy
  has_many :targets, inverse_of: :habit, dependent: :destroy
  has_many :users, through: :targets

  validates :title, presence: true
  validates_uniqueness_of :title

  scope :public, -> {
    includes(:targets)
    .where('targets.private = ?', false)
    .references(:targets)
  }

  private

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

end
