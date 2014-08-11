app.controller 'HabitsController', ($scope, $state, $http, Checkin, Habit) ->
  $http
    url: '/users/authenticated_user'
    method: 'GET'
  .success (data) ->
    Habit.getList().then (habits) ->
      $state.go 'app.habits.new', _, reload: true if habits.length == 0
      $scope.habits = habits
  .error (error) ->
    $state.go 'login'

  $scope.checkin = (habitId, value) ->
    Checkin.post
      value: value
      habit_id: habitId
    .then ->
      $state.go 'app.habits', null, reload: true
