app.controller 'HabitNewController', ($scope, $state, api) ->
  $scope.isEditable = true
  $scope.habit = {}
  $scope.target =
    timeframe: 'week'
  $scope.timeFrameOptions = ['day','week','month']

  $scope.save = ->
    api.habits.create
      title: $scope.habit.title
      unit: $scope.habit.unit
      private: $scope.habit.private or false
    .then (habit) ->
      api.targets.create
        habit_id: habit.id
        value: $scope.target.value
        timeframe: $scope.target.timeframe
      .then ->
        $state.go 'app.habits', _, reload: true
