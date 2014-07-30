class HabitsList < Dill::List
  root '#habits-list'
  item '.habit-listing' do
    widget :title, '.habit-title'
  end

  widget :habit_item, -> (title) {
    ['#habits-list .habit-listing', text: title]
  }

  def occurences(title)
    items.select { |e| e.widget(:title).value() == title }.size
  end

  def has_habit?(title)
    widget?(:habit_item, title)
  end

  def has_habit_with_visibility?(title, visibility)
    widget?(:habit_item, title) and widget(:habit_item, title).classes.include? visibility
  end
end
