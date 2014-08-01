App.HabitsNewController = Ember.ObjectController.extend
  timeframeOptions: ['Daily', 'Weekly', 'Monthly']
  timeframe: 'Weekly'
  targetValue: 10
  actions:
    habitSelected: (habit) ->
      @content.set('title', habit.value)
      @content.set('unit', habit.unit)
      @content.set('user_count', habit.user_count)
