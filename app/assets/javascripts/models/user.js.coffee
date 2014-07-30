App.User = DS.Model.extend
  habits: DS.hasMany 'habits'
  email: DS.attr 'string'
  password: DS.attr 'string'
