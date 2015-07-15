intersail.eventHandlers.AttachHandler = class AttachHandler extends intersail.lib.Model
  defaults = {
    mainContainerSelector: "div#main-container",
    detailContainerSelector: "div.detail-container",
    detailWrapperSelector: "div#detail-wrapper",
    baseContainerSelector: "div#node-scroll",
    nodeSelector: "li.list-element"
  }

  constructor: (@eventHandlers, @options = {}) ->
    @initializeOptions()

  # inizialize shared data between the handlers
  initializeOptions: ->
    intersail.__.defaults(@options, defaults)
    @mainContainerSelector = @options.mainContainerSelector
    @detailContainerSelector = @options.detailContainerSelector
    @detailWrapperSelector = @options.detailWrapperSelector
    @baseContainerSelector = @options.baseContainerSelector
    @nodeSelector = @options.nodeSelector

  # call #attachEvents on all handlers
  update: ->
    for handler in @eventHandlers
      handler.attachEvents(this)

  # set himself as the global event handler
  setCurrent: ->
    intersail.eventHandlers.current = this

  isCurrent: ->
    intersail.eventHandlers.current == this