app.factory 'HabitEditable', ->
  ($scope, originalHabit, originalTarget) ->
    _.extend $scope,
      isEditable: true
      habit: originalHabit
      target: originalTarget
      timeFrameOptions: ['day','week','month']
      onSelect: ($item, $model) ->
        _.extend $scope,
          isEditable: false
          habit: $model
      cancel: ->
        _.extend $scope,
          isEditable: true
          habit: originalHabit
          target: originalTarget
