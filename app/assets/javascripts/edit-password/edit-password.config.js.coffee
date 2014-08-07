app.config ($stateProvider) ->
  $stateProvider.state 'edit-password',
    url: '/edit-password/:reset_password_token'
    templateUrl: 'edit-password'
    controller: 'EditPasswordController'
