App.HabitRoute = Ember.Route.extend Ember.SimpleAuth.AuthenticatedRouteMixin,
  model: (params) ->
    @store.find 'habit', params.habit_id
  afterModel: (model) ->
    App.checkinsController.set('content', model.get('checkins'))
  actions:
    editHabit: ->
      @transitionTo('habits.edit', @currentModel)
    checkin: (habit, direction, note) ->
      value = if direction is 'plus' then habit.newCheckinValue else -habit.newCheckinValue
      App.checkin.call(this, value, note).call(this, habit, @get('session.user_id'))
