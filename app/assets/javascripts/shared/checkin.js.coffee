App.checkin = (value) ->
  (habit, userId) ->
    checkin = @store.createRecord 'checkin',
      value: value
      habit: habit
      user_id: userId
    checkin.save().then =>
      @store.reloadRecord habit
