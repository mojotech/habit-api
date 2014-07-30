App.HabitController = Ember.ObjectController.extend
  myCheckinValue:(->
    @get('model.checkins').reduce ((prev, checkin) =>
      if +@get('session.user_id') is +checkin.get('user_id')
        prev += checkin.get('value')
      else
        prev
    ), 0
  ).property('model.checkins')
