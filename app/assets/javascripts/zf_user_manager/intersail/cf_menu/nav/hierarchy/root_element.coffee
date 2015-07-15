intersail.nav.RootElement = class RootElement extends intersail.nav.ListElement
  constructor: (@id, @identifier)->
    @createNullObject()

  createNullObject: ->
    for prop, value of this
      if typeof value == 'function'
        eval("this.#{prop} = function(){}");
      else
        # only allow children and id property
        eval("this.#{prop}={}") unless prop == "children" || prop == "identifier" || prop == "id"