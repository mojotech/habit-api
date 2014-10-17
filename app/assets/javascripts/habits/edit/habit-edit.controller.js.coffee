app.controller 'HabitEditController', ($scope, $state, habit, $http, target, Habit, Target, HabitEditable) ->

  _.extend $scope, new HabitEditable($scope, habit, target),
    $scope.target.originalUnit = target.unit
    $scope.conversionType = "*"
    $scope.conversionFactor = 1

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
          factor: $scope.conversionFactor
          type: $scope.conversionType
      .then ->
        $state.go 'app.habits', null, reload: true
    deleteHabit: (habit) ->
      target.remove().then ->
        $state.go 'app.habits', null, reload: true

  $scope.conversionResult = () ->
    if $scope.conversionFactor
      if $scope.conversionType == "*"
        $scope.habit.last_checkin_value * $scope.conversionFactor
      else if $scope.conversionType == "/"
        $scope.habit.last_checkin_value / $scope.conversionFactor

  $scope.showUnitConversionForm = ->
    if $scope.target.originalUnit != target.unit
      return true
    else
      return false
