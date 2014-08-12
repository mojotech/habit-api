app.controller 'SignupController', ($scope, $state, auth) ->
  $scope.closeFlash = ->
    $scope.errors = []
    $scope.displayNameError = false
    $scope.emailError = false
    $scope.passwordError = false

  $scope.signup = ->
    $scope.errors = []
    $scope.emailError = false
    $scope.passwordError = false
    $scope.displayNameError = false
    if $scope.user
      credentials =
        display_name: $scope.user.displayName
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
        displayNameErrors = _.map error.data.display_name, (e) -> "display name #{e}"
        emailErrors = _.map error.data.email, (e) -> "email #{e}"
        passwordErrors = _.map error.data.password, (e) -> "password #{e}"
        $scope.errors = displayNameErrors.concat(emailErrors).concat(passwordErrors)
        $scope.displayNameError = (displayNameErrors.length > 0)
        $scope.emailError = (emailErrors.length > 0)
        $scope.passwordError = (passwordErrors.length > 0)
    else
      $scope.errors = ['Please provide a display name, email and password.']
      $scope.emailError = true
      $scope.passwordError = true
      $scope.displayNameError = true
