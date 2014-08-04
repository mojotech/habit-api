App.HabitController = Ember.ObjectController.extend
  timeframe: Ember.computed 'content.targets@each.timeframe', ->
    target = @get('model.targets').find (t) =>
      +t.get('user').id is +@get('session.user_id')
    target?.get?('timeframe')
  targetValue: Ember.computed 'content.targets@each.value', ->
    target = @get('model.targets').find (t) =>
      +t.get('user').id is +@get('session.user_id')
    target?.get?('value')
  formattedTimeFrame: Ember.computed 'content.targets@each.timeframe', ->
    target = @get('model.targets').find (t) =>
      +t.get('user').id is +@get('session.user_id')
     formattedTimeFrames[target?.get('timeframe')]
  percentage: Ember.computed 'model.value', ->
    target = @get('model.targets').find (t) =>
      +t.get('user').id is +@get('session.user_id')
    "#{+(@get('model.value') / target?.get('value') or 0).toFixed(2) * 100}%"

formattedTimeFrames =
  week: 'this week'
  month: 'this month'
  day: 'today'
