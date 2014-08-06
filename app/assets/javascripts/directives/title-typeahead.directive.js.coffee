app.directive 'habitTitleTypeahead', () ->
  restrict: 'EA'
  scope:
    habit: '=habitModel'
  template: '''
      <input id='title'
        sf-typeahead
        options='typeahead.options'
        datasets='typeahead.data'
        ng-model='selection'
        placeholder='Title'>
      </input>
    '''
  controller: ($scope) ->
    $scope.selection = null

    titleSuggestions = new Bloodhound
      datumTokenizer: (d) -> Bloodhound.tokenizers.whitespace(d.title)
      queryTokenizer: Bloodhound.tokenizers.whitespace
      remote: '/habits?title=%QUERY'

    titleSuggestions.initialize()

    $scope.typeahead =
      options:
        highlight: true
      data:
        displayKey: 'title'
        source: titleSuggestions.ttAdapter()

  link: (scope, el, attrs, ctrl) ->
    scope.$watch 'selection', (nu) ->
      if nu
        if _.isObject nu
          scope.habit = nu
        else
          scope.habit = title: nu
