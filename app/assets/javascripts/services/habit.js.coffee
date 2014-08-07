app.factory 'Habit', (Restangular) ->
  Restangular.all 'habits'
