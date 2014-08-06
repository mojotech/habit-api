app.config ($stateProvider) ->
  $stateProvider.state 'login',
    url: '/login'
    templateUrl: 'login'
    controller: 'LoginController'
