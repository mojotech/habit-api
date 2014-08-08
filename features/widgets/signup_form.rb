class SignupForm < Dill::FieldGroup
  root '.signup-form'

  text_field :email, 'identification'
  text_field :password, 'password'
  widget :submit, 'button'

  widget :error, -> (message) {
    ['.alert .error', text: message]
  }

  def submit_form
    widget(:submit).click
  end
end
