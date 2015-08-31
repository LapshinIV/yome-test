Meteor.startup ->
  if People.find().count() is 0
    People.insert
      id: 'lelle'
      faceImage: '/images/lelle.jpg'
      name: 'Lennart Källbäck'
    People.insert
      id: 'dmitry'
      faceImage: '/images/dmitry.jpeg'
      name: 'Dmitry Kouznetsov'
    People.insert
      id: 'alex'
      faceImage: '/images/alex.jpg'
      name: 'Alexey Emshanov'
    People.insert
      id: 'ivan'
      faceImage: '/images/ivan.jpg'
      name: 'Ivan Lapshin'
