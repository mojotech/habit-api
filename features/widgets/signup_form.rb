class SignupForm < Dill::FieldGroup
  root 'form'

  text_field :email, 'identification'
  text_field :password, 'password'
  widget :submit, 'button'

  widget :error, -> (message) {
    ['.errors .error', text: message]
  }

  def submit_form
    widget(:submit).click
  end
end
