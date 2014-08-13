app.controller 'AccountSettingsController', ($scope, $state, $http, auth, Auth) ->
  auth.currentUser().then (user) ->
    $scope.displayName = user.display_name

  $scope.save = ->
    $scope.errors = []
    $http
      url: '/users/me'
      method: 'PATCH'
      params:
        display_name: $scope.displayName
    .success (data) ->
      $state.go 'app.habits'
    .error (error) ->
      displayNameErrors = _.map error.display_name, (e) -> "display name #{e}"
      $scope.displayNameErrors = (displayNameErrors.length > 0)
      $scope.errors = displayNameErrors

  $scope.closeFlash = ->
    $scope.errors = []
    $scope.displayNameErrors = false
