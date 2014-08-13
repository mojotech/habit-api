@app = angular.module 'habit',
  [
    'ui.router'
    'Devise'
    'ui.bootstrap'
    'restangular'
  ]

app.run (Restangular, auth) ->
  FastClick.attach document.body

  Restangular.setDefaultHeaders
    Authorization: auth.token()
