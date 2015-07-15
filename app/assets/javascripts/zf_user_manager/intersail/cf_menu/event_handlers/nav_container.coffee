# Manages window resize and component resize
intersail.eventHandlers.NavContainer = class NavContainer
  constructor: (@minSpacing = 15) ->

  handleEvent: (handler) ->
    @fetchData(handler)
    @adjustWidth(handler)

  activateResizable: () ->
    #@jtodoIMP make this work 
#    @domDetailContainer.resizable(
#      # resize on left
#      handles: 'w',
#    )

  adjustWidth: (handler)->
    #fix this to resize the wrapper to fix the container sum of size
    @domBaseContainer.width( @domMainContainer.width() - @domDetailWrapper.width() - @minSpacing )

    # increase container size
    if $(handler.detailContainerSelector).length > 1
      tot = 0
      for detailContainer in $(handler.detailContainerSelector).get()
          tot += $(detailContainer).width()
      @domDetailWrapper.width(tot + @minSpacing )

  fetchData: (handler) ->
    @domBaseContainer = $(handler.baseContainerSelector)
    @domMainContainer = $(handler.mainContainerSelector)
    @domDetailContainer = $(handler.detailContainerSelector)
    @domDetailWrapper = $(handler.detailWrapperSelector)

  attachEvents: (handler) ->
    @fetchData(handler)
    @activateResizable()

    # resizes
    $("body").on "resize", handler.mainContainerSelector, {element: this, handler: handler},  (event) ->
      event.data.element.handleEvent(event.data.handler)
    $("body").on "resize", handler.detailContainerSelector, {element: this, handler: handler},  (event) ->
      event.data.element.handleEvent(event.data.handler)
    # bootstrap tab click
    $("body").on "shown.bs.tab", 'a[data-toggle="tab"]', {element: this, handler: handler},  (event) ->
      event.data.element.handleEvent(event.data.handler)
    $( window ).on "resize", {element: this, handler: handler}, (event) ->
      event.data.element.handleEvent(event.data.handler)
