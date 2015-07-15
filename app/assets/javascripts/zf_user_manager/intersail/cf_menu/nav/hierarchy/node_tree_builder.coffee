intersail.nav.NodeTreeBuilder = class NodeTreeBuilder
  defaults = {
    # if you pass the childrenId in the json
    childrenIdGiven: false,
    # the name of the field that contain the children_id
    childrenIdField: "childrenId",
    # if you pass the siblingId in the json
    siblingIdGiven: false,
    # the name of the field that contain the parent_id
    parentIdField: "parentId"
  }

  constructor: (@elementClass = intersail.nav.NodeElement, @shareClass = intersail.lib.shared.Share, @options = {}) ->
    @share = new @shareClass()
    intersail.__.defaults(@options, defaults)

  build: (json)->
    nodes_json = json
    @buildFromObject(nodes_json)

  buildFromObject: (nodes_json) ->
    nodes = []
    rootNode = null
    #add each node
    for node_json in nodes_json
      # if root
      if eval("node_json.#{@options.parentIdField}") is 0 || eval("node_json.#{@options.parentIdField}") is undefined
        nodeToAdd = rootNode = new intersail.nav.RootElement(node_json.id, node_json.identifier)
      else
        nodeToAdd = @createNode(node_json)
      nodes.push nodeToAdd

    #set relations data
    for node, index in nodes
      node.parent = @searchNode(nodes, eval("nodes_json[index] && nodes_json[index].#{@options.parentIdField}"))
      if @options.siblingIdGiven
        node.sibling = @searchNode(nodes, nodes_json[index]?.siblingId)
      if @options.childrenIdGiven
        node.children = @searchNode(nodes, eval("nodes_json[index] && nodes_json[index].#{@options.childrenIdField}") )
      node.root = rootNode

    unless @options.childrenIdGiven
      for node, index in nodes
        node.children = @searchChildren(nodes_json, nodes, node.id)

    @setSiblings(nodes, nodes_json, node) unless @options.siblingIdGiven

    # hook
    @beforeSave(nodes)

    @saveSharedData(nodes)

    nodes

  beforeSave: (nodes) ->

  saveSharedData: (nodes) ->
    throw "You need to implement this method in your class."

  createNode: (data) ->
    throw "You need to implement this method in your class."
  ###
  # Search functions
  ###
  # sets sibling automatically merging nodes with the same parent
  setSiblings: (nodes) ->
    for node in nodes
      for possible_sibling in nodes
        # if has the same parent, is not him and still has no sibling
        if possible_sibling.parent == node.parent && possible_sibling.id != node.id && possible_sibling.sibling == null
          node.sibling = possible_sibling
          break


  searchChildren: (nodes_json, nodes, id) ->
    for node in nodes_json
      return @searchNode(nodes, node.id) if eval("node.#{@options.parentIdField}") == id
    null

  searchParent: (nodes_json, nodes, id) ->
    for node in nodes_json
      return @searchNode(nodes, node.id) if eval("node.#{@options.childrenIdField}") == id
    null

  searchNode: (nodes, id) ->
    for node in nodes
      return node if  node.id == id && id != undefined
    null
