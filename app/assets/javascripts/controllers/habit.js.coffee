App.HabitController = Ember.ObjectController.extend
  targetProp: (prop, fallback)->
    target = @get('model.targets').find (t) =>
      +t.get('user').id is +@get('session.user_id')
    if target
      target.get prop
    else
      fallback
  timeframe: Ember.computed 'content.targets@each.timeframe', ->
    @targetProp 'timeframe'
  targetValue: Ember.computed 'content.targets@each.value', ->
    @targetProp 'value', 0
  formattedTimeFrame: Ember.computed 'content.targets@each.timeframe', ->
    {
      week: 'this week'
      month: 'this month'
      day: 'today'
    }[@get('timeframe')]
  percentage: Ember.computed 'model.value', ->
    "#{+(@get('model.value') / @get('targetValue')).toFixed(2) * 100}%"
