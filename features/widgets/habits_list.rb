class HabitsList < Dill::List
  root '#habits-list'

  item '.habit-listing' do
    widget :habit, '.habit-title'
  end

  def has_habit?(title)
    habit_titles.include?(title)
  end

  def habit_titles
    items.map { |i| i.widget(:habit).value }
  end

  def occurences(title)
    occurences = 0
    habit_titles.each do |t|
      occurences += 1 if t == title
    end
    occurences
  end
end
