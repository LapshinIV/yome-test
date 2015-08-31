Meteor.startup ->

  class App.app extends Famous.Node    # extends помогает для правильной установки прототипа?

    constructor: (@options) ->
      super @options                                                          # super - имплементация текущей функции прототипа объекта
                                                                              # implementation — это подтип связи realization.
                                                                              #   Судя по всему, на одном конце связи — конкретный класс,
                                                                              #   а на другом — интерфейс.
                                                                              # realization возникает между элементами диаграммы классов,
                                                                              #   когда один класс реализует поведение, определяемое другим классом.
      @meteor_collection_people_ready = options.meteor_collection_people_ready
      Meteor.setTimeout(@build, 1000)

    build: =>
      @makeApp this

    makeApp: (rootNode) ->
      rootNode.el = new Famous.DOMElement rootNode
      rootNode.el.setProperty 'background', '#FAFAFA'

      moneyNode = rootNode.addChild new App.MoneyPanel()

      saveButtonNode = rootNode.addChild()                                          #Добавляет новый дочерний узел. Если этот метод вызывается без аргументов он создаст новый узел, однако она также может быть вызвана с существующего узла, который будет добавляться к узлу
      saveButtonNode.el = new Famous.DOMElement saveButtonNode, { tagName: 'img' }  #привязываемся в ноде дом элементом (т.е отображение)
      saveButtonNode.el.setAttribute('src', './images/arrow.png')
      saveButtonNode.setSizeMode 'absolute', 'absolute', 'absolute'
      saveButtonNode.setAbsoluteSize 50, 50
      saveButtonNode.setAlign(1, 1)
      saveButtonNode.setMountPoint(1, 1)
      saveButtonNode.setPosition(-50, -50)
      saveButtonNode.el.setProperty 'background-color', 'grey'
      saveButtonNode.el.setProperty 'border-radius', '22px'
#      saveButtonNode.el.setContent '+'
      saveButtonNode.addUIEvent 'click'
      saveButtonNode.onReceive = (e,p) =>                                              # event| payload!!!!!!!!!!!!
        if e is 'click' and Object.keys(Session.get('bill').persons).length is 0
          console.log('you must tap on persons!')
        if e is 'click' and Object.keys(Session.get('bill').persons).length isnt 0
          saveButtonNode.el.setProperty 'background-color', 'orange'
        if e is 'click' and Object.keys(Session.get('bill').persons).length isnt 0
          saveButtonNode.el.setAttribute('src', './images/okk.png')
          saveButtonNode.el.setProperty 'background-color', 'white'
          console.log moment().format(), 'Bills collection count:', Bills.find().count()
          bill = Session.get 'bill'
          # todo: :-) we can't know the payer until we use user-accounts and have log-in; severity=dependent
          bill.payer = " пушкин"
          # todo:
          # bill from the Session will look like this:
          # {
          # 	"_id" : "NG7PiPtGJ4tbg9HRM",
          # 	"sum" : 300,
          # 	"persons" : {
          # 		"lelle" : {
          # 			"_id" : "p768b7TsAePY2TB8r",
          # 			"id" : "lelle", - !!! not needed for bills
          # 			"faceImage" : "/images/lelle.jpg", - !!! not needed for bills
          # 			"name" : "Lennart Källbäck", - !!! not needed for bills
          # 			"duty" : 150
          # 		},
          # 		"dmitry" : {
          # 			... ,
          #       "duty": 150
          # 		}
          # 	},
          # 	"payer" : " пушкин"
          # }
          #
          # bill should be "washed" before being saved
          Bills.insert bill
          console.log moment().format(), 'Bills collection count:', Bills.find().count()
          Meteor.setTimeout(( ->
            saveButtonNode.el.setAttribute('src', './images/arrow.png')
            saveButtonNode.el.setProperty 'background-color', 'orange'), 1000)

          console.log(Session.get('bill'))
          Session.set 'bill',
            sum: 300,
            persons: {}
          console.log(Session.get('bill'))


      if @meteor_collection_people_ready
        # todo: code duplicate! vomiting
        personListNode = rootNode.addChild new App.PersonList()
        # todo: get rid of magic number 100 below - get MoneyPanel's y position
        personListNode.setPosition 0, 100

      rootNode.onReceive = (e,p) =>
        if e is 'meteor-collection-people-ready'
          console.log 'custom event:', e
          # todo: code duplicate! vomiting
          personListNode = rootNode.addChild new App.PersonList()
          # todo: get rid of magic number 100 below - get MoneyPanel's y position
          personListNode.setPosition 0, 100
