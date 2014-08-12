app.config ($stateProvider) ->
  $stateProvider.state 'settings',
    url: '/settings'
    templateUrl: 'account-settings'
    controller: 'AccountSettingsController'
