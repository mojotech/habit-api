app.controller 'LogoutController', ($scope, $state, auth) ->
  auth.logout().then ->
    $state.go 'login', _, reload: true
