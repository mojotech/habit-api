app.filter "percentage", ($filter) ->
  (input, decimals) ->
    $filter("number")(input * 100, decimals)
