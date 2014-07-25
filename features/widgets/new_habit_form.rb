class NewHabitForm < Dill::Form
  root 'form'

  text_field :title, 'title'
  text_field :unit, 'unit'
  check_box :private, 'private'

  widget :save, '.save'

  def submit_form
    widget(:save).click
  end
end
