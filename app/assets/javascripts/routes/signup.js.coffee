App.SignupRoute = Ember.Route.extend
  model: -> {}
  actions:
    signUp: ->
      user = @store.createRecord 'user',
        email: @currentModel.identification
        password: @currentModel.password
      user.save().then (success) =>
        @get('session')
          .authenticate "ember-simple-auth-authenticator:devise",
            identification: @currentModel.identification
            password: @currentModel.password
