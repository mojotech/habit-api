app.factory 'User', (Restangular) ->
  Restangular.all 'users'
