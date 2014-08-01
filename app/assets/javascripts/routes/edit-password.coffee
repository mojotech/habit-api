App.EditPasswordRoute = Ember.Route.extend
  model: (params) ->
    @controllerFor(@routeName).set('resetPasswordToken', params.reset_password_token)
    return
