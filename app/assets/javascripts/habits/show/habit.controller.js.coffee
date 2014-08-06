app.controller 'HabitController', ($scope, $state, habit, target, checkins, api) ->
  constructHabit = (habit, checkins) ->
    _.extend habit,
      target: _.extend target[0],
        formattedTimeFrame: (week: 'this week', month: 'this month', day: 'today')[target[0].timeframe]
      percentage: (habit.value / target[0].value).toFixed(2) * 100
      {checkins}

  $scope.habit = constructHabit habit, checkins

  $scope.checkin = (direction) ->
    api.checkins.create
      habit_id: habit.id
      value: if direction is 'minus' then -$scope.newCheckin.value else $scope.newCheckin.value
      note: $scope.newCheckin.note
    .then (checkin) ->
      $scope.habit.checkins.unshift checkin
      api.habits.show(habit.id).then (habit) ->
        $scope.habit = constructHabit habit, $scope.habit.checkins
