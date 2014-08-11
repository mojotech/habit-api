app.controller 'AccountSettingsController', ($scope, $http, auth) ->
  auth.getCurrentUser (user) ->
    $scope.displayName = user.display_name
