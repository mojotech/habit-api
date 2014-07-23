@App = Ember.Application.create()
App.ApplicationSerializer = DS.ActiveModelSerializer

Ember.SimpleAuth.Authenticators.Devise.reopen
  serverTokenEndpoint: "/users/sign_in"

Ember.Application.initializer
  name: 'authentication',
  initialize: (container, application) ->
    Ember.SimpleAuth.setup container, application,
      authorizerFactory: 'ember-simple-auth-authorizer:devise'

require = (resource, fn) ->
  asArray = resource.toArray()
  if asArray.length
    fn(asArray)
  else
    0

# Models
App.Habit = DS.Model.extend
  title: DS.attr 'string'
  unit: DS.attr 'string'
  private: DS.attr 'boolean'
  checkins: DS.hasMany 'checkin'
  users: DS.hasMany 'user'
  newCheckinValue: 1
  value: DS.attr 'number'
  maxCheckin: Ember.computed 'checkins', ->
    require @get('checkins'), (checkins) ->
      _.max(checkins, (checkin) ->
        checkin.get('value')).get('value')
  minCheckin: Ember.computed 'checkins', ->
    require @get('checkins'), (checkins) ->
      _.min(checkins, (checkin) ->
        checkin.get('value')).get('value')
  lastCheckin: Ember.computed 'checkins', ->
    require @get('checkins'), (checkins) ->
      _.last(checkins).get('value')
  isEditable:(->
    @get('private') == true or !@get('user_count') > 0
  ).property('private', 'user_count')

App.Checkin = DS.Model.extend
  habit: DS.belongsTo 'habit'
  value: DS.attr 'number'
  email: DS.attr 'string'
  created_at: DS.attr 'date'
  user_id: DS.attr 'number'

App.User = DS.Model.extend
  habits: DS.hasMany 'habits'
  email: DS.attr 'string'
  password: DS.attr 'string'

# Routes

App.ApplicationRoute = Ember.Route.extend Ember.SimpleAuth.ApplicationRouteMixin

App.Router.map ->
  @route 'login'
  @route 'signup'
  @resource 'habits'
  @resource 'habits.new', path: '/habits/new'
  @resource 'habit', path: '/habits/:habit_id'
  @resource 'habits.edit', path: '/habits/:habit_id/edit'

App.LoginController = Ember.Controller.extend Ember.SimpleAuth.LoginControllerMixin,
  authenticatorFactory: 'ember-simple-auth-authenticator:devise'

App.HabitController = Ember.ObjectController.extend
  myCheckinValue:(->
    @get('model.checkins').reduce ((prev, checkin) =>
      if +@get('session.user_id') is +checkin.get('user_id')
        prev += checkin.get('value')
      else
        prev
    ), 0
  ).property('model.checkins')

App.HabitsController = Ember.ArrayController.extend
  itemController: 'habit'

App.HabitsNewController = Ember.ObjectController.extend
  actions:
    habitSelected: (habit) ->
      @content.set('title', habit.value)
      @content.set('unit', habit.unit)
      @content.set('user_count', habit.user_count)

App.HabitsEditController = Ember.ObjectController.extend
  actions:
    habitSelected: (habit) ->
      @content.set('title', habit.value)
      @content.set('unit', habit.unit)
      @content.set('user_count', habit.user_count)

App.checkinsController = Ember.ArrayController.create
  sortProperties: ['created_at']
  sortAscending: false

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

_checkin = (value) ->
  (habit, userId) ->
    checkin = @store.createRecord 'checkin',
      value: value
      habit: habit
      user_id: userId
    checkin.save().then =>
      @store.reloadRecord habit

App.HabitsRoute = Ember.Route.extend Ember.SimpleAuth.AuthenticatedRouteMixin,
  afterModel: (habits) ->
    if habits.content.length is 0
      @transitionTo 'habits.new'
  model: -> 
    @store.find 'habit'
  actions:
    plusOne: _checkin(1)
    minusOne: _checkin(-1)

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

App.HabitsEditRoute = Ember.Route.extend Ember.SimpleAuth.AuthenticatedRouteMixin,
  model: (params) -> @store.find('habit', params.habit_id)
  actions:
    save: ->
      @currentModel.save().then =>
        @store.unloadAll 'habit'
        @transitionTo 'habits'
    cancel: ->
      @currentModel.rollback()

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
      _checkin.call(this, value).call(this, habit, @get('session.user_id'))

App.IndexRoute = Ember.Route.extend
  redirect: ->
    @transitionTo 'habits'

App.TwitterTypeaheadComponent = Ember.TextField.extend
  tagName: "input"
  attributeBindings: ["placeholder", "id", "disabled"]
  didInsertElement: ->
    @$().typeahead(
      name: @get("name") or "typeahead"
      limit: @get("limit") or 5
      minLength: @get("minLength") or 5
      remote:
        url: @get("remote") or null
        filter:  (data) ->
          _(data.habits).sortBy((habit) ->
            habit.user_ids.length
          ).map((habit) ->
            value: habit.title
            unit: habit.unit
            user_count: habit.user_count
          ).value().reverse()
      template: @get("customTemplate") or null
      engine:
        compile: (template) ->
          compiled = Handlebars.compile(template)
          render: (context) ->
            compiled context
    ).on "typeahead:selected typeahead:autocompleted", (e, datum) =>
      @sendAction "action", datum
