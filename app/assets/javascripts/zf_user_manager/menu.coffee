//= require ./intersail/cf_menu/autoload.js

searchNode = (nodes, id) ->
  for node in nodes
    return node if  node.id == id && id != undefined
  null

fetchUnits = ->
  # fetch and prepare data
  units = JSON.parse(window.units)
  root = {
    id: 999999,
    identifier: "999999"
  }
  foundRootChild = false
  for unit in units
    unless unit.parent_id
      unit.parent_id = root.id
      foundRootChild = true
    unit.identifier = unit.id.toString()
    unit.label = unit.name
    unit.attributes = {}
    unit.options = {headersEnabled: false}
  units.push(root)
  # if nobody has as parent the root i search for one with parent_id orphan
  unless foundRootChild
    for unit in units
      if (searchNode(units, unit.parent_id) == null && unit.id != root.id)
        unit.parent_id = root.id

  units

ready = ->
    return unless window.units
    builder = new intersail.nav.CoverFlowBuilder intersail.nav.ListElement, null, {parentIdField: "parent_id", }
    builder.build(fetchUnits())
    shared = new intersail.lib.shared.Share

    mainNode = shared.listNodes[0].root.children
    # nodes init

    mainNode.initializeGui()
    mainNode.attachEvents()
    # search
#      cfSearch = new intersail.nav.coverFlowSearch
#      cfSearch.attachEvents()
    # node event handler
    nodeHandler = new intersail.gui.NodeHandler([])
    nodeHandler.attachEvents()
    # attach event handlers
    handler = new intersail.eventHandlers.AttachHandler([
      new intersail.eventHandlers.NavContainer()
    ], {
      mainContainerSelector: "div.zum_viewer_table",
      detailContainerSelector: "div.zum_manager_inspector",
    })
    handler.setCurrent()
    handler.update()
    # select selected node if present
    selected = window.unit_selected
    if selected
      nodes = new intersail.nav.NodesCollection
      nodes.find(selected)?.selectAndShow()


$(document).ready(ready)
$(document).on('page:load', ready)
$(document).on('update:data', ready)