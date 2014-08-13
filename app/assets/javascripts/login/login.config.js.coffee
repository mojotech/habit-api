app.config ($stateProvider) ->
  $stateProvider.state 'login',
    url: '/login?redirect'
    templateUrl: 'login'
    controller: 'LoginController'
