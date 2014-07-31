App.SignupRoute = Ember.Route.extend
  model: -> { error_messages: [] }
  actions:
    signUp: ->
      controller = @controllerFor(@routeName)
      controller.set('error_messages', [])
      user = @store.createRecord 'user',
        email: @currentModel.identification
        password: @currentModel.password
      user.save().then((success) =>
        @get('session')
          .authenticate "ember-simple-auth-authenticator:devise",
            identification: @currentModel.identification
            password: @currentModel.password
      ).fail((error) ->
        errors = error.responseJSON
        error_messages = []
        if errors.email
          for e in errors.email
            error_messages.push "email #{e}"
        if errors.password
          for e in errors.password
            error_messages.push "password #{e}"
        controller.set('error_messages', error_messages)
      )

