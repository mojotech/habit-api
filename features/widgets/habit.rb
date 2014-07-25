class HabitItem < Dill::Widget
  root { |title| ['#habits-list .habit-listing .habit-title', text: title] }
end
