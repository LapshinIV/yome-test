Meteor.startup ->

  class App.PersonListItem extends Famous.Node

    constructor: (@options) ->
      super @options
      @options.size ?= 48
      @padding = 5
      @height = @padding + @options.size + @padding
      @build(this)
    console.log('2')
    build: (rootNode) ->
      console.log('1')
      rootNode.setSizeMode 'relative', 'absolute'
      rootNode.setAbsoluteSize 0, rootNode.height
      rootNode.el = new Famous.DOMElement rootNode, content: ' '
      rootNode.el.setProperty 'background', '#F5F5F5'
      rootNode.el.setProperty 'border-bottom', '2px solid darkgray'
      rootNode.el.setProperty 'cursor', 'pointer'

      textNode = rootNode.addChild()
      textNode.el = new Famous.DOMElement textNode, content: ' '
      textNode.el.setProperty 'padding-left', "#{rootNode.padding + rootNode.options.size + rootNode.padding*2}px"
      textNode.el.setProperty 'line-height', "#{rootNode.height}px"
      textNode.el.setProperty 'vertical-align', 'middle'
      textNode.el.setProperty 'font-size', '12px'

      faceNode = rootNode.addChild new App.Face({ img: rootNode.options.person.faceImage, size: rootNode.options.size })
      faceNode.setPosition rootNode.padding, rootNode.padding

      App.renderTemplateWithData Template.PersonListItem, rootNode.options.person, textNode
      console.log('222')
      rootNode.el.onReceive = (e,p) ->
        console.log('333')
        if e is 'test'
          rootNode.el.setProperty 'background', '#F5F5F5'

      rootNode.gestures = new Famous.GestureHandler rootNode

      rootNode.gestures.on 'tap', (e,p) =>
        @emit 'test2'                     #bill.Add.friend() -> @emit "test"
        recalculateDuties = () ->
          for k,v of @persons
            v.duty = @sum / _.size(@persons)

        clickedPerson = rootNode.options.person
        bill = Session.get 'bill'
        if bill.persons[clickedPerson.id]
          rootNode.el.setProperty 'background', '#F5F5F5'
          console.log('white')
          delete bill.persons[clickedPerson.id]
          @emit 'test3'
        else
          rootNode.el.setProperty 'background', '#E0E0E0'
          console.log('grey')
          bill.persons[clickedPerson.id] = clickedPerson
        recalculateDuties.call(bill)
        Session.set 'bill', bill

      rootNode.gestures.on 'drag', (e,p) =>
        currentPos = rootNode.getPosition()
        newPosX = currentPos[0] + e.centerDelta.x
        if newPosX < 0
          newPosX = 0
        rootNode.setPosition newPosX, currentPos[1]
        if e.status is 'end'
          textPosition = new Famous.Position(rootNode)
          textPosition.setX 0, { duration: 300, curve: 'inOutExpo' }, () ->
            console.log 'done!'
