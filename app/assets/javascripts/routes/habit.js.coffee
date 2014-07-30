App.HabitRoute = Ember.Route.extend Ember.SimpleAuth.AuthenticatedRouteMixin,
  model: (params) ->
    @store.find 'habit', params.habit_id
  afterModel: (model) ->
    App.checkinsController.set('content', model.get('checkins'))
  actions:
    removeHabit: ->
      @modelFor('habit').destroyRecord().then =>
        @transitionTo 'habits'
    editHabit: ->
      @transitionTo('habits.edit', @currentModel)
    checkin: (habit, direction) ->
      value = if direction is 'plus' then habit.newCheckinValue else -habit.newCheckinValue
      App.checkin.call(this, value).call(this, habit, @get('session.user_id'))