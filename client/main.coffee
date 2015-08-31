Meteor.startup ->
  meteor_collection_people_ready = People.find().count() > 0
  @app = new App.app({meteor_collection_people_ready: meteor_collection_people_ready})

Template.main.rendered = =>
  scene = Famous.Engine.createScene()
  scene.addChild @app
  Famous.Engine.init()

Tracker.autorun () =>
  console.log moment().format(), "People collection count: ", People.find().count()
  if @app and not @app.meteor_collection_people_ready and People.find().count() > 0
    @app.emit 'meteor-collection-people-ready'
    @app.meteor_collection_people_ready = true
