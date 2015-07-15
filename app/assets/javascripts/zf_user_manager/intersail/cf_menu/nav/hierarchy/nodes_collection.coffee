intersail.nav.NodesCollection = class NodesCollection
  constructor: (@searchClass = intersail.nav.coverFlowSearch, @defaultFields = ["identifier"]
  ,@shareClass = intersail.lib.shared.Share, @sharedElementName = "listNodes") ->
    @share = new @shareClass
    @search = new @searchClass @fetchNodes()

  fetchNodes: ->
    eval("this.share.#{@sharedElementName}")

  where: (value, fields = @defaultFields) ->
    @search.searchNodes(value, fields)

  find: (id) ->
    @where(id, ["identifier"])?[0] || null

  all: ->
    @fetchNodes()

  advancedWhere: (conditions = {}) ->
    @search.advancedSearch(conditions)

  activateSelected: ->
    node = @advancedWhere([
      {
        key: "selected",
        value: true,
        operator: "="
      },
      {
        key: "children",
        value: null,
        operator: "="
      }
    ])
    @search.activateNode(node[0]) if node.length > 0

  addSelectedNode: (node) ->
    shared = @share.selectedNodes || []
    shared.push(node)
    @share.selectedNodes = shared

  clearSelectedNodes: ->
    @share.selectedNodes = []

  selectedNodes: ->
    @share.selectedNodes || []

  selectedLeaf: ->
    @selectedNodes()[0]

  triggerSelectedNodeClick: ->
    @search.dispatchEventsOn(@selectedLeaf()) if @selectedLeaf()
