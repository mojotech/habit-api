class HabitItem < Dill::Widget
  root { |title| ['#habits-list .habit-listing', text: title] }

  widget :positive_checkin, '.plus'
  widget :negative_checkin, '.minus'
  widget :value, '.value'
  widget :title, '.habit-title'
  widget :link, '.title a'

  def click
    widget(:link).click
  end
end
