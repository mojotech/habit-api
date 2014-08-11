app.controller 'AccountSettingsController', ($scope, $http, auth) ->
  auth.getCurrentUser (user) ->
    $scope.user.displayName = user.displayName
