app.controller 'SignupController', ($scope, $state, auth) ->
  $scope.closeFlash = ->
    $scope.errors = []
    $scope.emailError = false
    $scope.passwordError = false

  $scope.signup = ->
    $scope.errors = []
    $scope.emailError = false
    $scope.passwordError = false
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
        emailErrors = _.map error.data.email, (e) -> "email #{e}"
        passwordErrors = _.map error.data.password, (e) -> "password #{e}"
        $scope.errors = emailErrors.concat passwordErrors
        $scope.emailError = (emailErrors.length > 0)
        $scope.passwordError = (passwordErrors.length > 0)
    else
      $scope.errors = ['Please provide an email and password.']
      $scope.emailError = true
      $scope.passwordError = true
