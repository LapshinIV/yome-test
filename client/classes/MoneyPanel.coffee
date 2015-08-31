Meteor.startup ->

  class App.MoneyPanel extends Famous.Node
    constructor: (@options) ->
      super @options
      @build(this)

    build: (rootNode) ->
      rootNode.setSizeMode 'relative', 'absolute'
      rootNode.setAbsoluteSize 0, 100
      rootNode.el = new Famous.DOMElement rootNode, content: ' '
      rootNode.el.setProperty 'background', '#E0E0E0'
      rootNode.el.setProperty 'line-height', '100px'
      rootNode.el.setProperty 'vertical-align', 'middle'
      rootNode.el.setProperty 'text-align', 'center'
      rootNode.el.setProperty 'font-size', '32px'
      rootNode.el.setProperty 'border-bottom', '2px solid grey'

      App.renderTemplate Template.money, rootNode
