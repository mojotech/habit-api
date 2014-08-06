# like ng-include except no new scope
app.directive 'staticInclude', ($templateCache, $compile) ->
  (scope, element, attrs) ->
    c = element.html($templateCache.get attrs.staticInclude).contents()
    $compile(c) scope
