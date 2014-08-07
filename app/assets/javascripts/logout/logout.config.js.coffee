app.config ($stateProvider) ->
  $stateProvider.state 'logout',
    url: '/logout'
    controller: 'LogoutController'
