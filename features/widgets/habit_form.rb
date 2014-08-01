class HabitForm < Dill::Form
  root 'form'

  text_field :title, 'title'
  text_field :unit, 'unit'
  widget :locked_title, '.locked-title'
  widget :locked_unit, '.locked-unit'
  check_box :private, 'private'

  widget :save, '.save'
  widget :cancel, '.cancel'

  text_field :target_value, 'target-value'
  select :timeframe, 'target-timeframe'

  def submit_form
    widget(:save).click
  end
end
