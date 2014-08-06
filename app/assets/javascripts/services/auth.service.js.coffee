app.service 'auth', (Auth) ->
  signup: (credentials) ->
    Auth
      .register credentials
      .then ->
        Auth.login credentials
  login: Auth.login
  logout: Auth.logout
  token: ->
    if Auth._currentUser
      user = Auth._currentUser
      "Token token=\"#{user.user_token}\", user_email=\"#{user.user_email}\""
    else
      ""
