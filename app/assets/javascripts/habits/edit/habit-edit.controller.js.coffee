app.controller 'HabitEditController', ($scope, $state, habit, $http, target, Habit, Target, HabitEditable) ->

  _.extend $scope, new HabitEditable($scope, habit, target),
    $scope.target.originalUnit = target.unit
    suggestions: (query) ->
      $http.get "/habits?title=#{query}"
      .then (results) ->
        results.data
    save: ->
      target.patch
        habit_attributes:
          title: $scope.habit.title
        value: $scope.target.value
        timeframe: $scope.target.timeframe
        unit: $scope.target.unit
        private:  $scope.target.private
        conversion:
          factor: $scope.conversion.factor
          type: $scope.conversion.type
      .then ->
        $state.go 'app.habits', null, reload: true
    deleteHabit: (habit) ->
      target.remove().then ->
        $state.go 'app.habits', null, reload: true

  $scope.conversionResult = () ->
    if $scope.conversion.factor
      if $scope.conversion.type == "*"
        $scope.habit.last_checkin_value * $scope.conversion.factor
      else if $scope.conversion.type == "/"
        $scope.habit.last_checkin_value / $scope.conversion.factor
