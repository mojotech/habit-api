App.checkin = (value, note) ->
  (habit, userId) ->
    checkin = @store.createRecord 'checkin',
      value: value
      habit: habit
      user_id: userId
      note: note
    checkin.save().then =>
      @store.reloadRecord habit
