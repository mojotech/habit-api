app.controller 'HabitEditController', ($scope, $state, habit, target, Habit, Target) ->

  $scope.isEditable = true
  $scope.habit = habit
  $scope.target = target
  $scope.timeFrameOptions = ['day','week','month']

  $scope.suggestions = (query) ->
    $http.get "/habits?title=#{query}"
    .then (results) ->
      _.map results.data, (habit) -> "habit.title (#{habit.user_count})"

  $scope.onSelect = ($item, $model, $label) ->
    $scope.isEditable = false
    $http.get "/habits?title=#{$label}"
    .then (results) ->
      habit = results.data[0]
      $scope.habit.title = habit.title
      $scope.habit.unit = habit.unit
      $scope.habit.user_count = habit.user_count

  $scope.cancel = ->
    $scope.habit.user_count = 0
    $scope.habit.title = ''
    $scope.habit.unit = ''
    $scope.habit.private = false
    $scope.isEditable = true

  $scope.save = ->
    habit.put
      title: $scope.habit.title
      unit: $scope.habit.unit
      private: $scope.habit.private
    .then (habit) ->
      target.put
        habit_id: habit.id
        value: $scope.target.value
        timeframe: $scope.target.timeframe
      .then ->
        $state.go 'app.habits', null, reload: true

  $scope.deleteHabit = (habit) ->
    habit.remove().then ->
        $state.go 'app.habits', null, reload: true
