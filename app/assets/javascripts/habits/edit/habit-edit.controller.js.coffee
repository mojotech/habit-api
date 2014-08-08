app.controller 'HabitEditController', ($scope, $state, habit, $http, target, Habit, Target) ->

  $scope.isEditable = true
  $scope.habit = habit
  $scope.target = target
  $scope.timeFrameOptions = ['day','week','month']

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
