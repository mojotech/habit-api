App.Habit = DS.Model.extend
  title: DS.attr 'string'
  unit: DS.attr 'string'
  private: DS.attr 'boolean'
  checkins: DS.hasMany 'checkin'
  users: DS.hasMany 'user'
  targets: DS.hasMany 'target'
  newCheckinValue: 1
  value: DS.attr 'number'
  isEditable:(->
    @get('private') == true or !@get('user_count') > 0
  ).property('private', 'user_count')
  shared:(->
    @get('users.length') > 1
  ).property('users')
