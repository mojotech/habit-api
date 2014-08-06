app.controller 'HabitEditController', ($scope, $state, habit, target, api) ->
  $scope.isEditable = true
  $scope.habit = habit
  $scope.target = target
  $scope.timeFrameOptions = ['day','week','month']

  $scope.save = ->
    api.habits.update habit.id,
      title: $scope.habit.title
      unit: $scope.habit.unit
      private: $scope.habit.private
    .then (habit) ->
      api.targets.update target.id,
        habit_id: habit.id
        value: $scope.target.value
        timeframe: $scope.target.timeframe
      .then ->
        $state.go 'app.habits', null, reload: true
