App.LogoutRoute = Ember.Route.extend Ember.SimpleAuth.AuthenticatedRouteMixin,
  beforeModel: ->
    @get('session').invalidate()
