app.controller 'HabitsController', ($scope, $state, api, auth, habits) ->
  $scope.habits = habits
  $state.go 'app.habits.new', _, reload: true if habits.length == 0
  $scope.checkin = (habitId, value) ->
    api.checkins.create
      value: value
      habit_id: habitId
      user_id: auth.currentUser.id
    .then ->
      $state.go 'app.habits', null, reload: true
