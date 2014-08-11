app.service 'auth', (Auth, $http) ->
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
  getCurrentUser: (callback) ->
    $http
      url: '/authenticated_user'
      method: 'GET'
    .success (data) ->
      console.log data
      callback(data)
    .error (error) ->
      console.log error
