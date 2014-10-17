@app = angular.module 'habit',
  [
    'ui.router'
    'Devise'
    'ui.bootstrap'
    'restangular'
    'angularMoment'
  ]

app.run ($rootScope, $state, Restangular, auth, Auth, $urlRouter) ->
  $rootScope.$state = $state

  FastClick.attach document.body

  Restangular.setDefaultHeaders
    Authorization: auth.token()

  publicStates = ["login", "signup", "forgot-password", "edit-password"]

  transition =
    to: null

  $rootScope.$on 'devise:unauthorized', (event, xhr, deferred) ->
    event.preventDefault()
    if _.contains publicStates, transition.to.name
      $urlRouter.sync()
    else
      $state.go 'login'

  $rootScope.$on '$stateChangeStart', (event, toState, toParams, fromState, fromParams) ->
    transition.to = toState
    Auth.currentUser().then (user) ->
      if _.contains(publicStates, toState.name)
        event.preventDefault()
        $state.go 'app.habits'

