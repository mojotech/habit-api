BASE = ''

get  = null
post = null
put  = null
del = null

app.service 'ApiHelper', ($http, auth) ->
  get = (resource, serializedParams, id) ->
    $http
      url: url resource, serializedParams, id
      method: 'GET'
      headers:
        Authorization: auth.token()
    .then (success) ->
      success.data

  post = (resource, serializedParams, id) ->
    $http
      url: url resource, serializedParams, id
      method: 'POST'
      headers:
        Authorization: auth.token()
    .then (success) ->
      success.data

  put = (resource, serializedParams, id) ->
    $http
      url: url resource, serializedParams, id
      method: 'PUT'
      headers:
        Authorization: auth.token()
    .then (success) ->
      success.data

  del = (resource, serializedParams, id) ->
    $http
      url: url resource, serializedParams, id
      method: 'DELETE'
      headers:
        Authorization: auth.token()
    .then (success) ->
      success.data

  {index, show, create, update, destroy}

serialize = (params) ->
  $.param params or {}

url = (resource, serializedParams, id) ->
  u = "#{BASE}/#{resource}"
  u += "/#{id}" if id?
  u += "?#{serializedParams}" if serializedParams
  u

create = (resource) ->
  (params) ->
    post resource, serialize params

update = (resource) ->
  (id, params) ->
    put resource, serialize(params), id

index = (resource) ->
  (params) ->
    get resource, serialize params

show = (resource) ->
  (id, params) ->
    get resource, serialize(params), id

destroy = (resource) ->
  (id, params) ->
    del resource, serialize(params), id
