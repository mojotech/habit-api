class LoginForm < Dill::FieldGroup
  root '.login-form'

  text_field :email, 'identification'
  text_field :password, 'password'
  widget :submit, 'button'
  widget :forgot_password, '.forgot-password'

  def submit_form
    widget(:submit).click
  end
end
