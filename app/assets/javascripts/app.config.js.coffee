app.config ($urlRouterProvider, $stateProvider) ->
  $stateProvider.state 'app',
    template: '<div ui-view="page">Loading...</div>'
  $urlRouterProvider.otherwise '/habits'
