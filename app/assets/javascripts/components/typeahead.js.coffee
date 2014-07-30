App.TwitterTypeaheadComponent = Ember.TextField.extend
  tagName: "input"
  attributeBindings: ["placeholder", "id", "disabled"]
  didInsertElement: ->
    @$().typeahead(
      name: @get("name") or "typeahead"
      limit: @get("limit") or 5
      minLength: @get("minLength") or 5
      remote:
        url: @get("remote") or null
        filter:  (data) ->
          _(data.habits).sortBy((habit) ->
            habit.user_ids.length
          ).map((habit) ->
            value: habit.title
            unit: habit.unit
            user_count: habit.user_count
          ).value().reverse()
      template: @get("customTemplate") or null
      engine:
        compile: (template) ->
          compiled = Handlebars.compile(template)
          render: (context) ->
            compiled context
    ).on "typeahead:selected typeahead:autocompleted", (e, datum) =>
      @sendAction "action", datum
