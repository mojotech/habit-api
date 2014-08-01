App.User = DS.Model.extend
  habits: DS.hasMany 'habits'
  checkins: DS.hasMany 'checkins'
  targets: DS.hasMany 'targets'
  email: DS.attr 'string'
  password: DS.attr 'string'
