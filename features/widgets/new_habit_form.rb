class NewHabitForm < Dill::FieldGroup
  root 'form'

  text_field :title, 'title'
  text_field :unit, 'password'
  widget :private, 'private'

  widget :save, 'save'

  def submit_form
    widget(:save).click
  end
end
