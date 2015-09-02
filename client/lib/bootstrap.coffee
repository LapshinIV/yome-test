#declare namespaces
window.Famous ?= {}
window.App ?= {}

`App.getElementFromDOMElement = function(node, callback) {
    var clock = Famous.Engine.getClock();
    var query = function() {
    var nodeId = node.getLocation();
    var elements = document.querySelector(nodeId.split('/')[0]).querySelectorAll('[data-fa-path]');
    for (var i = 0; i < elements.length; ++i) {
      if (elements[i].dataset.faPath === nodeId) {
          return callback(elements[i]);
      }
    }
    clock.setTimeout(query, 16);
    };
  // except for this :(
    clock.setTimeout(query, 64);
    };`

App.renderTemplate = (template, node) ->
  App.getElementFromDOMElement node, (el) =>
# get the content 'div'
    contentNode = el.childNodes[0]
# render our template into the content DIV
    Blaze.render template, contentNode

App.renderTemplateWithData = (template, data, node) ->
  App.getElementFromDOMElement node, (el) =>
# get the content 'div'
    contentNode = el.childNodes[0]
# render our template into the content DIV
    Blaze.renderWithData template, data, contentNode

Session.set 'bill',
  sum: 300,
  persons: {},
  myFunc: () ->
    console.log('hi')

myFunc = (bill) ->
  bill.sum > 0 and bill.persons.length > 0



class Cat
  constructor: (parameters) ->
    this.name = parameters.name
    this.age = parameters.age

  sound: () ->
    "meouw"
console.log('hi')
cat = new Cat({name: 'adsfasdf', age: 23})
Session.set 'cat', cat

console.log cat.sound()

