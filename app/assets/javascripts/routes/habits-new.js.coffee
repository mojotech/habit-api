App.HabitsNewRoute = Ember.Route.extend Ember.SimpleAuth.AuthenticatedRouteMixin,
  model: ->
    @store.createRecord 'habit'
  actions:
    save: ->
      @currentModel.save().then (habit) =>
        target = @store.createRecord 'target',
          value: @controller.get('targetValue')
          timeframe: @controller.get('timeframe').toLowerCase()
          habit: habit
          user_id: @get('session.user_id')

        target.save().then (target) =>
          @store.unloadAll 'habit'
          @store.unloadAll 'target'
          @transitionTo 'habits'

    cancel: ->
      @currentModel.set('user_count', 0)
      @currentModel.set('title', '')
      @currentModel.set('unit', '')
      @currentModel.set('private', false)
