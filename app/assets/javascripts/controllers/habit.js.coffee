App.HabitController = Ember.ObjectController.extend
  timeframe: Ember.computed 'content.targets@each.timeframe', ->
    target = @get('model.targets').find (t) =>
      +t.get('user').id is +@get('session.user_id')
    target?.get?('timeframe')
  targetValue: Ember.computed 'content.targets@each.value', ->
    target = @get('model.targets').find (t) =>
      +t.get('user').id is +@get('session.user_id')
    target?.get?('value')
