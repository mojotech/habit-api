class HabitItem < Dill::Widget
  root { |title| ['#habits-list .habit-listing', text: title] }

  widget :log, '.plus'
  widget :percentage, '.percentage'
  widget :title, '.habit-title'
  widget :link, 'a.title'
  widget :new_checkin_value, '.button-container'

  def click
    widget(:link).click
  end
end
