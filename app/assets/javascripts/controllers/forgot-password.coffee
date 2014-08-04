App.ForgotPasswordController = Ember.ObjectController.extend
  sentPasswordReset: false
  email: ''
  error: ''
  actions:
    resetPassword: (email) ->
      @set('error', '')
      $.ajax
        url: '/send_password_reset'
        method: 'POST'
        data: 
          email: email
        success: (data) =>
          @set('sentPasswordReset', true)
        error: (error) =>
          @set('error', error.responseJSON.error)
