App.Target = DS.Model.extend
  user: DS.belongsTo 'user'
  habit: DS.belongsTo 'habit'
  value: DS.attr 'number'
  timeframe: DS.attr 'string'
