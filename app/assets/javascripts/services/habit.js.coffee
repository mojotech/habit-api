app.factory 'Habit', (Restangular, Checkin, auth, $q) ->

  Restangular.extendModel 'habits', (model) ->
    model.lastCheckin = ->
      deferred = $q.defer()

      auth.currentUser().then (currentUser) ->
        Checkin
          .getList habit_id: model.id
          .then (checkins) ->
            deferred.resolve _(checkins).where(user_id: currentUser.id).first()

      deferred.promise
    model

  Restangular.all 'habits'