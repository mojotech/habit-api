@App = Ember.Application.create()
App.ApplicationSerializer = DS.ActiveModelSerializer

Ember.SimpleAuth.Authenticators.Devise.reopen
  serverTokenEndpoint: "/users/sign_in"

Ember.Application.initializer
  name: 'authentication',
  initialize: (container, application) ->
    Ember.SimpleAuth.setup container, application,
      authorizerFactory: 'ember-simple-auth-authorizer:devise'

App.ApplicationRoute = Ember.Route.extend Ember.SimpleAuth.ApplicationRouteMixin,
  actions:
    sessionAuthenticationFailed: (error) ->
      @controllerFor('login').set('error', 'Invalid email/password combination.')

App.Router.map ->
  @route 'login'
  @route 'signup'
  @resource 'habits'
  @resource 'habits.new', path: '/habits/new'
  @resource 'habit', path: '/habits/:habit_id'
  @resource 'habits.edit', path: '/habits/:habit_id/edit'
  @route 'logout'
  @route 'forgot_password'
  @route 'edit_password', path: '/edit_password/:reset_password_token'
