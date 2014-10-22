app.controller 'HabitNewController', (Restangular, $scope, $state, Habit, Target, habits, HabitEditable, $stateParams) ->
  _.extend $scope,
    new HabitEditable($scope, { title: $stateParams.title }, { timeframe: 'week', private: true })
    hasHabits: habits.length > 0
    save: ->
      resetErrors()
      saveTarget $scope.target
        .then andTransition, handleTargetErrors

  saveTarget = (target) ->
    Restangular.all('targets').post
      habit_attributes:
        title: $scope.habit.title
      value: target.value
      unit: target.unit
      timeframe: target.timeframe
      private: target.private

  andTransition = ->
    $state.go 'app.habits', null, reload: true

  handleTargetErrors = (response) ->
    valueErrors = _.map response.data.value, (e) -> "value #{e}"
    unitErrors = _.map response.data.unit, (e) -> "unit #{e}"
    sameTitleErrors = _.map response.data.habit_id, (e) -> "title #{e}"
    otherTitleErrors = _.map response.data['habit.title'], (e) -> "title #{e}"
    titleErrors = sameTitleErrors.concat otherTitleErrors

    _.extend $scope,
      errors: titleErrors.concat(valueErrors).concat unitErrors
      valueErrors: (valueErrors.length > 0)
      unitErrors: (unitErrors.length > 0)
      titleErrors: titleErrors.length > 0

  resetErrors = ->
    _.extend $scope,
      errors: []
      titleErrors: false
      unitErrors: false
      valueErrors: false
