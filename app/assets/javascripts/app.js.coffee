@app = angular.module 'habit',
  [
    'ui.router'
    'Devise'
    'ui.bootstrap'
    'restangular'
  ]

app.run ($rootScope, $state, Restangular, auth, Auth) ->
  FastClick.attach document.body
  Restangular.setDefaultHeaders
    Authorization: auth.token()

  $rootScope.$on '$stateChangeStart', (event, toState, toParams, fromState, fromParams) ->
    unauthorizedStates = ["login", "signup", "forgot-password", "edit-password"]
    if Auth.isAuthenticated()
      if !Auth._currentUser and !_.contains(unauthorizedStates, toState.name)
        $state.go 'login', { redirect: toState.name }
      else if Auth._currentUser and _.contains(unauthorizedStates, toState.name)
        $state.go 'app.habits'
