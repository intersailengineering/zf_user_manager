intersail.gui.NodeHandler = class NodeHandler
  @include intersail.nav.NodeClickModule

  defaults = {
    shareClass: intersail.lib.shared.Share
  }

  constructor: (@objs = [],@options = {}) ->
    @events = $({})
    @initializeOptions()
    @share = new @options.shareClass

  initializeOptions: ->
    intersail.__.defaults(@options, defaults)

  attachUpdateData: ->
    for obj in @objs
      @onUpdate(obj)

  onUpdate: (obj)->
    @events.on 'intersail.updateData', @updateClosure obj

  updateClosure: (obj) ->
    (event, data) ->
      obj.update(data)

  # Click handler
  attachEvents: ->
    @_attachClick()
    @attachUpdateData()

  onClickEvent: (node) ->
    @updateGui({node: node})

  updateGui: (options = {}) ->
    that = @
    select_record(options.node.identifier)
#   that.events.trigger 'intersail.updateData', [json_data]
