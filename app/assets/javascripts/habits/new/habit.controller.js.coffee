app.controller 'HabitNewController', ($scope, $state, $http, Habit, Target, habits) ->

  $scope.isEditable = true

  $scope.habit = {}

  $scope.target =
    timeframe: 'week'
  $scope.timeFrameOptions = ['day','week','month']

  $scope.hasHabits = habits.length > 0

  $scope.suggestions = (query) ->
    $http.get "/habits?title=#{query}"
    .then (results) ->
      results.data

  $scope.onSelect = ($item, $model, $label) ->
    $scope.isEditable = false
    $scope.habit.title = $model.title
    $scope.habit.user_count = $model.user_count

  $scope.cancel = ->
    $scope.habit.user_count = 0
    $scope.habit.title = ''
    $scope.target.unit = ''
    $scope.habit.private = false
    $scope.isEditable = true

  $scope.save = ->
    resetErrors()
    Habit.post
      title: $scope.habit.title
      private: $scope.habit.private or false
    .then ((habit) ->
      Target.post
        habit_id: habit.id
        value: $scope.target.value
        unit: $scope.target.unit
        timeframe: $scope.target.timeframe
      .then (->
        $state.go 'app.habits', null, reload: true
      ), (response) ->
        valueErrors = _.map response.data.value, (e) -> "value #{e}"
        unitErrors = _.map response.data.unit, (e) -> "unit #{e}"
        $scope.errors = valueErrors.concat unitErrors
        $scope.valueErrors = (valueErrors.length > 0)
        $scope.unitErrors = (unitErrors.length > 0)
    ), (response) ->
      titleErrors = _.map response.data.title, (e) -> "title #{e}"
      $scope.errors = titleErrors
      $scope.titleErrors = (titleErrors.length > 0)

  resetErrors = ->
    $scope.errors = []
    $scope.titleErrors = false
    $scope.unitErrors = false
    $scope.valueErrors = false
