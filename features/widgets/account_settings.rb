class AccountSettings < Dill::Form
  root '.account-settings'

  text_field :display_name, 'display-name'
  text_field :current_password, 'current-password'
  text_field :new_password, 'new-password'
  text_field :password_confirmation, 'password-confirmation'
  widget :save, '.save'

  widget :error, -> (message) {
    ['.alert .error', text: message]
  }
end
