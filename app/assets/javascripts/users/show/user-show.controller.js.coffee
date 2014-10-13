app.controller 'UserController', ($scope, $state, $stateParams, user, habits) ->
  $scope.user = user
  $scope.habits = habits