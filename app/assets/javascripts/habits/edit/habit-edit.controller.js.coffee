app.controller 'HabitEditController', ($scope, $state, habit, $http, target, Habit, Target, HabitEditable) ->

  _.extend $scope, new HabitEditable($scope, habit, target),
    suggestions: (query) ->
      $http.get "/habits?title=#{query}"
      .then (results) ->
        results.data
    save: ->
      target.patch
        habit_attributes:
          title: $scope.habit.title
          private:  $scope.habit.private
        value: $scope.target.value
        timeframe: $scope.target.timeframe
        unit: $scope.target.unit
      .then ->
        $state.go 'app.habits', null, reload: true
    deleteHabit: (habit) ->
      target.remove().then ->
        $state.go 'app.habits', null, reload: true
