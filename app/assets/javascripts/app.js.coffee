@app = angular.module 'habit',
  [
    'ui.router'
    'Devise'
    'ui.bootstrap'
    'restangular'
  ]

app.run (Restangular, auth) ->
  Restangular.setDefaultHeaders
    Authorization: auth.token()
