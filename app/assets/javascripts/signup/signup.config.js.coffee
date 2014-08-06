app.config ($stateProvider) ->
  $stateProvider.state 'signup',
    url: '/signup'
    templateUrl: 'signup'
    controller: 'SignupController'
