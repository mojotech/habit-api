app.service 'api', ($http, ApiHelper) ->
  habits:
    update: ApiHelper.update 'habits'
    index: ApiHelper.index 'habits'
    show: ApiHelper.show 'habits'
    create: ApiHelper.create 'habits'
    destroy: ApiHelper.destroy 'habits'
  targets:
    update: ApiHelper.update 'targets'
    index: ApiHelper.index 'targets'
    show: ApiHelper.show 'targets'
    create: ApiHelper.create 'targets'
  checkins:
    index: ApiHelper.index 'checkins'
    create: ApiHelper.create 'checkins'
