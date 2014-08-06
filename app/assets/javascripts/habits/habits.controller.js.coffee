app.controller 'HabitsController', ($scope, $state, habits) ->
  $scope.habits = habits
  $state.go 'app.habits.new', _, reload: true if habits.length == 0
