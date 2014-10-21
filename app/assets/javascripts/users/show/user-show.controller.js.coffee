app.controller 'UserController', ($scope, $state, $stateParams, user, habits) ->
  $scope.user = user
  $scope.habits = habits

  $scope.join = (habit) ->
    $state.go 'app.habits.new', { title: habit.title }
