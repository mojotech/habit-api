@app = angular.module 'habit',
  [
    'ui.router'
    'Devise'
    'ui.bootstrap'
    'restangular'
  ]

app.run ($rootScope, $state, Restangular, auth) ->
  Restangular.setDefaultHeaders
    Authorization: auth.token()
  $rootScope.$on '$stateChangeStart', (event, toState, toParams, fromState, fromParams) ->
    unauthorizedStates = ["login", "signup", "forgot-password", "edit-password"]
    auth.currentUser().then (user) ->
      if user.error and !_.contains(unauthorizedStates, toState.name)
        $state.go 'login'
      else if user.email and _.contains(unauthorizedStates, toState.name)
        $state.go 'app.habits'
