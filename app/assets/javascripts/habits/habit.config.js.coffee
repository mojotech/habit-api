app.config ($stateProvider) ->
  $stateProvider.state 'app.habits',
    url: '/habits'
    views:
      "page@app":
        templateUrl: 'habits'
        controller: 'HabitsController'
    resolve:
      habits: (api) ->
        api.habits.index()

  $stateProvider.state 'app.habits.new',
    url: '/new'
    views:
      "page@app":
        templateUrl: 'habits/new'
        controller: 'HabitNewController'

  $stateProvider.state 'app.habits.edit',
    url: '/:habitId/edit'
    views:
      "page@app":
        templateUrl: 'habits/edit'
        controller: 'HabitEditController'
    resolve:
      habit: (api, $stateParams, Auth) ->
        api.habits.show $stateParams.habitId
      target: (api, $stateParams) ->
        api.targets.show 0,
          habit_id: $stateParams.habitId

  $stateProvider.state 'app.habits.show',
    url: '/:habitId'
    views:
      "page@app":
        templateUrl: 'habit'
        controller: 'HabitController'
    resolve:
      habit: (api, $stateParams) ->
        api.habits.show $stateParams.habitId
      target: (api, $stateParams) ->
        api.targets.index habit_id: $stateParams.habitId
      checkins: (api, $stateParams) ->
        api.checkins.index habit_id: $stateParams.habitId
