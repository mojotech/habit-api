app.controller 'HabitController', ($scope, $state, habits, Checkin, Habit, $stateParams) ->

  $scope.habit = _.find habits, id: +$stateParams.habitId
  $scope.newCheckin = value: $scope.habit.last_checkin_value

  Checkin.getList(habit_id: $stateParams.habitId).then (checkins) ->
    $scope.habit.checkins = checkins

  $scope.checkin = (direction) ->
    $scope.error = ''

    $scope.newCheckin = $scope.newCheckin || {}

    Checkin.post
      habit_id: $scope.habit.id
      value: if direction is 'minus' then -$scope.newCheckin.value else $scope.newCheckin.value
      note: $scope.newCheckin.note
    .then ((checkin) ->
      $scope.newCheckin.value = checkin.value
      $scope.newCheckin.note = ''
      $scope.habit.checkins.unshift checkin
      Habit.get($scope.habit.id).then (habit) ->
        $scope.habit = _.extend habit, checkins: $scope.habit.checkins
    ), (response) ->
      $scope.error = "value #{response.data.errors.value[0]}"

  $scope.closeFlash = ->
    $scope.error = ''

  $scope.deleteCheckin = (checkin) ->
    $scope.habit.checkins.splice $scope.habit.checkins.indexOf(checkin), 1
    checkin.remove()

    Habit.get($scope.habit.id).then (habit) ->
      $scope.habit = _.extend habit, checkins: $scope.habit.checkins
