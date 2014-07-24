class HabitsList < Dill::List
  root '#habits-list'
  item '.habit-listing .habit-title'

  widget :habit_item, -> (title) {
    ['#habits-list .habit-listing .habit-title', text: title]
  }

  def occurences(title)
    items.select { |e| e.value == title }.size
  end

  def has_habit?(title)
    widget?(:habit_item, title)
  end
end
