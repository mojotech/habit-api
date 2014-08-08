app.controller 'LoginController', ($scope, $state, auth) ->
  $scope.closeFlash = ->
    $scope.error = ''

  $scope.login = ->
    $scope.error = ''
    if $scope.user
      auth.login
        email: $scope.user.email
        password: $scope.user.password
      .then ->
        $state.go 'app.habits', _, reload: true
    else
      $scope.error = 'Invalid email/password combination.'
  $scope.$on 'devise:unauthorized', (event, xhr, deferred) ->
    $scope.error = 'Invalid email/password combination.'
