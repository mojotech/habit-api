class AccountSettings < Dill::Form
  root '.account-settings'

  text_field :display_name, 'display-name'
  widget :save, '.save'

  widget :error, -> (message) {
    ['.alert .error', text: message]
  }
end
