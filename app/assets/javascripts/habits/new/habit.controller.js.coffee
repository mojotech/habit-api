app.controller 'HabitNewController', ($scope, $state, $http, Habit, Target, habits) ->

  $scope.isEditable = true

  $scope.habit = {}

  $scope.target =
    timeframe: 'week'
  $scope.timeFrameOptions = ['day','week','month']

  $scope.hasHabits = habits.length > 0

  $scope.suggestions = (query) ->
    $http.get "/habits?title=#{query}"
    .then (results) ->
      results.data

  $scope.onSelect = ($item, $model, $label) ->
    $scope.isEditable = false
    $scope.habit.title = $model.title
    $scope.habit.unit = $model.unit
    $scope.habit.user_count = $model.user_count

  $scope.cancel = ->
    $scope.habit.user_count = 0
    $scope.habit.title = ''
    $scope.habit.unit = ''
    $scope.habit.private = false
    $scope.isEditable = true

  $scope.save = ->
    Habit.post
      title: $scope.habit.title
      unit: $scope.habit.unit
      private: $scope.habit.private or false
    .then (habit) ->
      Target.post
        habit_id: habit.id
        value: $scope.target.value
        timeframe: $scope.target.timeframe
      .then ->
        $state.go 'app.habits', null, reload: true
