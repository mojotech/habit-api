class HabitDetails < Dill::FieldGroup
  root '.habit-details'

  widget :title, '.title'
  widget :delete, '.delete'
  widget :abandon, '.abandon'
  widget :edit, '.edit'
  widget :value, '.value'
  text_field :new_checkin_value, 'new-checkin-value'
  text_field :note, 'note'
  widget :positive_checkin, '.plus'
  widget :negative_checkin, '.minus'
  widget :target, '.target'

  widget :checkins, -> (note) {
    ['.checkin', text: note]
  }
end
