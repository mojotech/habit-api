secretEmptyKey = '[$empty$]'
app.directive 'emptyTypeahead', ->
  require: 'ngModel',
  controller: ($scope, $http) ->
    $scope.suggestions = (query) ->
      queryString = if query and query isnt secretEmptyKey
        "title=#{query}"
      else
        "suggestions=true"

      $http.get "/habits?#{queryString}"
        .then (results) ->
          results.data

  link: (scope, element, attrs, modelCtrl) ->
    scope.comparator = (option, viewValue) ->
      viewValue is secretEmptyKey || (''+option).toLowerCase().indexOf((''+viewValue).toLowerCase()) > -1

    scope.onFocus = (e) ->
      angular.element(e.target).triggerHandler 'input'
      return

    modelCtrl.$parsers.unshift (inputValue) ->
      value = if inputValue then inputValue else secretEmptyKey
      modelCtrl.$viewValue = value
      value

    modelCtrl.$parsers.push (inputValue) ->
      if inputValue is secretEmptyKey then '' else inputValue
