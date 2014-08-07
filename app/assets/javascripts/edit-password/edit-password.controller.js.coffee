app.controller 'EditPasswordController', ($scope, $stateParams, $http) ->
  $scope.errors = []
  $scope.password = ''
  $scope.passwordConfirmation = ''
  $scope.editPassword = ->
    $scope.errors = []
    $http
      url: '/change_password'
      method: 'POST'
      params:
        password: $scope.password
        password_confirmation: $scope.passwordConfirmation
        reset_password_token: $stateParams.reset_password_token
    .success (data) ->
      $scope.formSubmitted = true
    .error (error) ->
      $scope.errors = error.error
