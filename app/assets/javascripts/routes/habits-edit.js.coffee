App.HabitsEditRoute = Ember.Route.extend Ember.SimpleAuth.AuthenticatedRouteMixin,
  model: (params) -> @store.find('habit', params.habit_id)
  actions:
    save: ->
      target = @controller.get('model').get('targets').find (t) =>
        +t.get('user').id is +@get('session.user_id')
      target
        .set 'value',  @controller.get('targetValue')
        .set 'timeframe',  @controller.get('timeframe').toLowerCase()
        .save()
        .then =>
          @currentModel.save().then =>
            @store.unloadAll 'habit'
            @transitionTo 'habits'

    cancel: ->
      @currentModel.rollback()
