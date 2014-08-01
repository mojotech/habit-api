App.HabitsEditController = Ember.ObjectController.extend
  timeframeOptions: ['Daily', 'Weekly', 'Monthly']
  timeframe: 'Weekly'
  targetValue: Ember.computed 'content.targets@each.value', ->
    target = @get('model.targets').find (t) =>
      t.get('user').id is @get('session.user_id')
    target?.get?('value') or 10
  actions:
    habitSelected: (habit) ->
      @content.set('title', habit.value)
      @content.set('unit', habit.unit)
      @content.set('user_count', habit.user_count)
