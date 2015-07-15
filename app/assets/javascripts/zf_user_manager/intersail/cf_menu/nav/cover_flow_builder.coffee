intersail.nav.CoverFlowBuilder = class CoverFlowBuilder extends intersail.nav.NodeTreeBuilder
  constructor: (@elementClass = intersail.nav.ListElement, @shareClass = intersail.lib.shared.Share, @options = {}) ->
    super(@elementClass, @shareClass, @options)

  saveSharedData: (nodes) ->
    @share.listNodes = nodes

  # This is the method that creates the actual node element from a data item
  createNode: (data) ->
    new @elementClass(data.id, data.label, data.labelHeader, null, null, null, data.identifier, data.attributes, data.options)