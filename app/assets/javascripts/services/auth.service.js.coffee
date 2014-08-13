app.service 'auth', (Auth, $http, $q) ->
  signup: (credentials) ->
    Auth.register credentials
  login: Auth.login
  logout: Auth.logout
  token: ->
    if Auth._currentUser
      user = Auth._currentUser
      "Token token=\"#{user.user_token}\", user_email=\"#{user.user_email}\""
    else
      ""
  currentUser: (callback) ->
    d = $q.defer()
    $http
      url: '/users/me'
      method: 'GET'
    .success (data) ->
      d.resolve data
    d.promise
