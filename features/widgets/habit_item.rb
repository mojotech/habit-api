class HabitItem < Dill::Widget
  root { |title| ['#habits-list .habit-listing', text: title] }

  widget :log, '.plus'
  widget :value, '.value'
  widget :title, '.habit-title'
  widget :link, '.title a'

  def click
    widget(:link).click
  end
end
