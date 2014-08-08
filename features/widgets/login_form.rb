class LoginForm < Dill::FieldGroup
  root '.login-form'

  widget :error, '.alert'
  text_field :email, 'identification'
  text_field :password, 'password'
  widget :submit, 'button'

  def submit_form
    widget(:submit).click
  end
end
