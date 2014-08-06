app.controller 'SignupController', ($scope, $location, auth) ->
  $scope.signup = ->
    auth.signup
      email: $scope.user.email
      password: $scope.user.password

    .then ->
      $location.path 'habits'
