app.controller 'HabitsController', ($scope, $state, auth, habits, Habit, Checkin) ->

    $scope.habits = _.map habits, (habit) ->
      habit.lastCheckin().then (lastCheckin) ->
        if lastCheckin?.value
          habit.lastCheckinValue = lastCheckin.value
        else
          habit.lastCheckinValue = 1
      habit

    $state.go 'app.habits.new', _, reload: true if habits.length == 0

    $scope.checkin = (habitId, value) ->

# Take the habits array and replace all the habits with
# their corresponding habit id, and then assign that new
# array to a variable called habitIdsArray

# Post the new value to the database
      Checkin.post
        value: value
        habit_id: habitId
      .then ->
# Then do a get request for the information for that
# same habit back from the database
        Habit.get(habitId).then (habit) ->
          habitIdsArray = $scope.habits.map (habit) ->
            habit = habit.id
          $scope.habits.splice habitIdsArray.indexOf(habit.id), 1, habit
#Grab the last checkin value and assign it to lastCheckinValue
          habit.lastCheckin().then (lastCheckin) ->
            habit.lastCheckinValue = lastCheckin.value





