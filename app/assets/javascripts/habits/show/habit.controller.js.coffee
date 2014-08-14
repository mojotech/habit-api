app.controller 'HabitController', ($scope, $state, habit, target, checkins, Checkin, Habit) ->
  constructHabit = (habit, checkins) ->
    _.extend habit,
      target: _.extend target,
        formattedTimeFrame: (week: 'this week', month: 'this month', day: 'today')[target.timeframe]
      percentage: (habit.value / target.value * 100 ).toFixed(0)
      {checkins}

  $scope.habit = constructHabit habit, checkins

  $scope.checkin = (direction) ->
    $scope.error = ''
    $scope.newCheckin = $scope.newCheckin || {}
    Checkin.post
      habit_id: habit.id
      value: if direction is 'minus' then -$scope.newCheckin.value else $scope.newCheckin.value
      note: $scope.newCheckin.note
    .then ((checkin) ->
      $scope.newCheckin.value = ''
      $scope.newCheckin.note = ''
      $scope.habit.checkins.unshift checkin
      Habit.get(habit.id).then (habit) ->
        $scope.habit = constructHabit habit, $scope.habit.checkins
    ), (response) ->
      $scope.error = "value #{response.data.errors.value[0]}"

  $scope.closeFlash = ->
    $scope.error = ''
