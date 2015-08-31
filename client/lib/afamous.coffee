Meteor.startup ->
  Famous.Engine = famous.core.FamousEngine
  Famous.DOMElement = famous.domRenderables.DOMElement

  Famous.Node = famous.core.Node
  Famous.GestureHandler = famous.components.GestureHandler
  Famous.Position = famous.components.Position
