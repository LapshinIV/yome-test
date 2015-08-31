Meteor.startup ->

  # WARNING!!! do not forget to change App.new_component_name to your component's name
  class App.PersonList extends Famous.Node
    constructor: (@options) ->
      super @options
      @build(this)

    build: (rootNode) ->
      persons = {}
      persons[p.id] = p for p in (People.find().map (e) -> e)

      yPos = 0;
      for k,v of persons
        personItemNode = rootNode.addChild new App.PersonListItem({ size: 64, person: v})
        personItemNode.setPosition 0, yPos
        yPos += personItemNode.height
