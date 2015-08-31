Meteor.startup ->

  class App.Face extends Famous.Node

    constructor: (@options) ->
      super @options
      @options.size ?= 48
      @build(this)

    build: (rootNode) ->
      rootNode.setSizeMode 'absolute', 'absolute'
      rootNode.setAbsoluteSize rootNode.options.size, rootNode.options.size
      rootNode.el = new Famous.DOMElement(rootNode, {tagName: "img"})
      rootNode.el.setAttribute('src', rootNode.options.img)
    #   rootNode.el.setProperty 'background-image', "url(#{@options.img})"
    #   rootNode.el.setProperty 'background-size', "#{@options.size}px #{@options.size}px"
      rootNode.el.setProperty 'border-radius', "#{rootNode.options.size/2}px"
#      rootNode.el.setProperty 'border', '3px solid grey'
#      rootNode.el.setProperty 'padding', '2px'

