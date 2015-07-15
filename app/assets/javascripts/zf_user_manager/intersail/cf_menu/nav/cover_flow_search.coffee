intersail.nav.coverFlowSearch = class CoverFlowSearch
  @include intersail.nav.NodeClickModule

  defaults = {
    maxResults: 500
    resultsContainerSelector: "div#results-wrapper",
    domObjUlSelector: "#search-results ul",
    domObjDivSelector: "#search-results",
  }

  constructor: (@nodes = null, @fields = ["label"], @objId = "search-text",
                @shareClass = intersail.lib.shared.Share, @options = {}) ->
    @share = new @shareClass()
    @nodes ||= @share.listNodes
    @initializeOptions()
    @domObj = $("##{@objId}")
    @domObjUl = $(@options.domObjUlSelector)
    @domObjDiv = $(@options.domObjDivSelector)
    @initializeGui()

  initializeOptions: ->
    intersail.__.defaults(@options, defaults)

  initializeGui: ->
    @activateResize()

  activateResize: ->
    $(@options.resultsContainerSelector).resizable(
      # resize on bottom
      handles: 's',
      maxHeight: 400
    )

  searchNodes: (value, fields = @fields) ->
    intersail.__.filter(@nodes, (node) ->
      valid = false
      for field in fields when node.getAttr(field)?.toLowerCase().indexOf(value?.toLowerCase()) > -1
        valid = true
      valid
    )

  # pass an array of hash like this [{key: "field", "value": "value", operator: "="}]
  advancedSearch: (conditions = []) ->
    intersail.__.filter(@nodes, (node) ->
      valid = true
      # for now the only default operator is AND
      for condition in conditions
        nodeValue = node.getAttr(condition.key)
        expectedValue = condition.value
        switch condition.operator
          when "="
            valid = false if nodeValue != expectedValue
          when "!="
            valid = false if nodeValue == expectedValue
      valid
    )

  updateGui: (event)->
    @showResults(event)

  hide: ->
    @domObjDiv.hide()
    @domObj.val("")

  # Click event
  onClickEvent: (node) ->
    @activateNode(node)

  activateNode: (node) ->
    node.selectAndShow()
    node.scrollToVerticalPosition()
    @dispatchEventsOn(node)

  # Other events
  attachEvents: ->
      # search on keyup
    @domObj.on "keyup", {element: this}, (event) ->
      event.data.element.updateGui(event)
    # close search result
    $("#close").on "click", {element: this}, (event) ->
      event.data.element.hide()
    @_attachClick()

  dispatchEventsOn: (node) ->
    except = [@]
    @_runAllClosuresOn(node, except)

  nodeSelector: ->
      "li.search-result a"

  clickFindSelector: (event)->
    $(event.target).closest("a").attr("data-id")

  # Rendering
  showResults: (event, fields = @fields) ->
    value = event.target.value
    # handle escape click
    if event.keyCode == intersail.lib.const.keymap.escapeKeyCode
      @domObj.val("")
      return @domObjDiv.hide()

    unless value.length > 2
      return @domObjDiv.hide()
    @domObjUl.empty()

    totalResults = 0
    for node in @searchNodes(value, fields)
      totalResults += 1
      break if totalResults > @options.maxResults
      @domObjUl.append @resultHtml(node)

    @domObjDiv.show() unless @domObjDiv.is(":visible")
    @domObjUl.append("<li class='no-results'>Nessun risultato trovato.</li>") unless totalResults > 0

  resultHtml: (node) ->
    html = "<li class=\"search-result\">"
    # list all the tree starting from the node
    currentNode = node
    nodeList = [currentNode]
    loop
      currentNode = currentNode.parent
      break unless currentNode
      nodeList.push(currentNode)
    # print it top to bottom
    for currentNode in nodeList by -1
      html += "<a href='#' data-id='#{currentNode.identifier}'>#{currentNode.label}
                    <i class=\"fa fa-chevron-right\"></i></a>"
    html += "</li>"
