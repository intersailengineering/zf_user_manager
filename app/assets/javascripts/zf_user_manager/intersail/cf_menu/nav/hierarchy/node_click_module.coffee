# USAGE:
# call  @_attachClick() in your base class
# implement the onClickEvent hook in your class, this method will
# pass you the object associated to the node clicked
# you can also override the nodeSelector method to use another css selector
# for the node
intersail.nav.NodeClickModule = class NodeClickModule
  nodeSelector: ->
    @_defaultNodeSelector()

  onClickEvent: (found) ->
    throw "You need to implement this method in your class."

  ###
  # Do not edit below here
  ###
  _attachClick: ->
    @_clickClosure = @._buildClosure(@)
    return if @_hasAttached(@constructor.name)
    @_attachEvent(@constructor.name)

    $("body").on "click", @nodeSelector() ,{that: this},  (event) ->
        event.preventDefault()
        that = event.data.that
        # find the node
        nodesCollection = new intersail.nav.NodesCollection()
        found = nodesCollection.find( that.clickFindSelector(event) )
        # call the closure
        that._runClosure(that._clickClosure, found, that)

  clickFindSelector: (event)->
    @_defaultClickFindSelector(event)

  _defaultClickFindSelector: (event) ->
    $(event.target).closest("li").attr("data-id")

  _runClosure: (closureData, found, that = null) ->
    closure = closureData.closure
    that ||= closureData.obj
    closure.apply(that, [found])

  _runAllClosuresOn: (node, excepts = []) ->
    closuresData = @_share().nodeClickClosureData || []

    for closureData in closuresData
      @_runClosure(closureData, node) unless @_needToSkip(closureData, excepts)

  _needToSkip: (closureData, excepts) ->
    for except in excepts
      return true if closureData.obj == except
    false

  _buildClosure: (that)->
    closure = that.onClickEvent
    @_saveClosure(closure, that)

  _saveClosure: (closure, that) ->
    closuresData = @_share().nodeClickClosureData || []

    data = {
      obj: that,
      closure: closure
    }

    # update closure Data
    closuresData.push(data)
    @_share().nodeClickClosureData = closuresData

    data

  _share: ->
    new intersail.lib.shared.Share()

  _defaultNodeSelector: ->
    "li.list-element"

  ###
  # lazy call attach on events
  ###
  _attachedEvents: ->
    @_share().attachedEvents || []

  _cleanEvents: ->
    @_share().attachedEvents = []

  _attachEvent: (name) ->
    @_share().attachedEvents = @_share().attachedEvents ? []
    @_share().attachedEvents.push(name)

  _hasAttached: (name) ->
    for event in @_attachedEvents()
      return true if event == name
    false
