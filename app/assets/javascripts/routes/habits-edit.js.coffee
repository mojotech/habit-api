App.HabitsEditRoute = Ember.Route.extend Ember.SimpleAuth.AuthenticatedRouteMixin,
  model: (params) -> @store.find('habit', params.habit_id)
  actions:
    save: ->
      @currentModel.save().then =>
        @store.unloadAll 'habit'
        @transitionTo 'habits'
    cancel: ->
      @currentModel.rollback()
