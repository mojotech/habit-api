app.config ($stateProvider) ->
  $stateProvider.state 'app.users',
    url: '/users/:userId'
    views:
      "page@app":
        templateUrl: 'user'
        controller: 'UserController'
    resolve:
      user: ($stateParams, User) ->
        User.get $stateParams.userId
      habits: ($stateParams, Habit) ->
        Habit.getList(user_id: $stateParams.userId)
