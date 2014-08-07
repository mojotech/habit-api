app.controller 'SignupController', ($scope, $state, auth) ->
  $scope.signup = ->
    $scope.errors = []
    if $scope.user
      credentials =
        email: $scope.user.email
        password: $scope.user.password
      auth.signup(
        credentials
      ).then (->
        auth.login
          email: $scope.user.email
          password: $scope.user.password
        .then =>
          $state.go 'app.habits', _, reload: true
      ), (error) ->
        $scope.errors =
          _.map error.data.email, (e) -> "email #{e}"
          .concat _.map error.data.password, (e) -> "password #{e}"
    else
      $scope.errors = ['Please provide an email and password.']
