app.controller 'HabitsController', ($scope, $state, auth, habits, Checkin) ->

    $scope.habits = _.map habits, (habit) ->
      habit.lastCheckin().then (lastCheckin) ->
        if lastCheckin?.value
          habit.lastCheckinValue = lastCheckin.value
        else
          habit.lastCheckinValue = 1
      habit

    $state.go 'app.habits.new', _, reload: true if habits.length == 0

    $scope.checkin = (habitId, value) ->
      Checkin.post
        value: value
        habit_id: habitId
      .then ->
        $state.go 'app.habits', null, reload: true
