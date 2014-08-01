App.EditPasswordController = Ember.ObjectController.extend
  errors: []
  passwordChanged: false
  newPassword: ''
  confirmNewPassword: ''
  resetPasswordToken: ''
  resetPassword: false
  actions:
    changePassword: ->
      @set('errors', [])
      $.ajax
        url: '/change_password'
        method: 'POST'
        data:
          password: @get('newPassword')
          password_confirmation: @get('confirmNewPassword')
          reset_password_token: @get('resetPasswordToken')
        success: (data) =>
          @set('resetPassword', true)
        error: (error) =>
          @set('errors', error.responseJSON.errors)
