app.config ($stateProvider) ->
  $stateProvider.state 'app.habits',
    url: '/habits'
    views:
      "page@app":
        templateUrl: 'habits'
        controller: 'HabitsController'
    resolve:
      habits: (Habit) ->
       Habit.getList()

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
      habit: ($stateParams, Habit) ->
        Habit.get $stateParams.habitId
      target: ($stateParams, Target) ->
        Target.get 0, habit_id: $stateParams.habitId

  $stateProvider.state 'app.habits.show',
    url: '/:habitId'
    views:
      "page@app":
        templateUrl: 'habit'
        controller: 'HabitController'
