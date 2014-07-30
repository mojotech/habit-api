App.HabitsNewRoute = Ember.Route.extend Ember.SimpleAuth.AuthenticatedRouteMixin,
  model: ->
    @store.createRecord 'habit'
  actions:
    save: ->
      @currentModel.save().then =>
        @store.unloadAll 'habit'
        @transitionTo 'habits'
    cancel: ->
      @currentModel.set('user_count', 0)
      @currentModel.set('title', '')
      @currentModel.set('unit', '')
      @currentModel.set('private', false)
