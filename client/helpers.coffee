Template.money.helpers
  'sum': ->
    Session.get('bill').sum + ' SEK'

Template.PersonListItem.helpers
  'personDuty': ->
    person = Session.get('bill').persons[@.id]
    if person
      if person.duty > 0
        person.duty + ' SEK'
