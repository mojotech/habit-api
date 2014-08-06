app.controller 'LogoutController', ($scope, $state, auth, api) ->
  auth.logout().then ->
    $state.go 'login', _, reload: true
