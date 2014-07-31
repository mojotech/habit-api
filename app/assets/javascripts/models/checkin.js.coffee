App.Checkin = DS.Model.extend
  habit: DS.belongsTo 'habit'
  value: DS.attr 'number'
  email: DS.attr 'string'
  created_at: DS.attr 'date'
  user_id: DS.attr 'number'
  note: DS.attr 'string'
