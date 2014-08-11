class ForgotPasswordForm < Dill::Form
  root '.forgot-password'

  text_field :email, 'email'
  widget :reset, '.reset'
  widget :sent, '.sent'
  widget :error, '.error'
end
