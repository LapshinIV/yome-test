Meteor.startup ->

  # WARNING!!! do not forget to change App.new_component_name to your component's name
  class App.new_component_name extends Famous.Node
    constructor: (@options) ->
      super @options
      @build(this)

    build: (rootNode) ->
