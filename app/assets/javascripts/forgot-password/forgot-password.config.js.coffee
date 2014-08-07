app.config ($stateProvider) ->
  $stateProvider.state 'forgot-password',
    url: '/forgot-password'
    templateUrl: 'forgot-password'
    controller: 'ForgotPasswordController'
