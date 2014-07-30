App.HabitsRoute = Ember.Route.extend Ember.SimpleAuth.AuthenticatedRouteMixin,
  afterModel: (habits) ->
    if habits.content.length is 0
      @transitionTo 'habits.new'
  model: ->
    @store.find 'habit'
  actions:
    plusOne: App.checkin(1)
    minusOne: App.checkin(-1)
