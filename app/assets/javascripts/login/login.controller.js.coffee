app.controller 'LoginController', ($scope, $location, auth, api) ->
  $scope.login = ->
    auth.login
      email: $scope.user.email
      password: $scope.user.password
    .then ->
      $location.path 'habits'
