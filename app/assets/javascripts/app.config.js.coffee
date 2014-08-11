app.config ($urlRouterProvider, $stateProvider) ->
  $stateProvider.state 'app',
    template: '<div ui-view="page"></div>'
  $urlRouterProvider.otherwise '/habits'
