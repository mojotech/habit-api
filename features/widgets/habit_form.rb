class HabitForm < Dill::Form
  root '.habit-form'

  text_field :title, 'title'
  text_field :unit, 'unit'
  widget :locked_title, '.locked-title'
  widget :locked_unit, '.locked-unit'
  check_box :private, 'private'

  widget :save, '.save'
  widget :cancel, '.cancel'

  text_field :target_value, 'target-value'
  select :timeframe, 'target-timeframe'

  widget :delete, '.delete'
  widget :abandon, '.abandon'

  widget :error, -> (message) {
    ['.alert .error', text: message]
  }

  def submit_form
    widget(:save).click
  end
end
