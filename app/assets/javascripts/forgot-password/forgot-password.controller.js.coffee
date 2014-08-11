app.controller 'ForgotPasswordController', ($scope, $http) ->
  $scope.resetPassword = ->
    $scope.error = ''

    $http
      url: '/send_password_reset'
      method: 'POST'
      params:
        email: $scope.email
    .success (data) ->
      $scope.sentPasswordReset = true
    .error (error) ->
      $scope.error = error.error
