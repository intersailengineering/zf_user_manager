# A node element that can handle tree hierarchy as
# a binary tree with right sibling and direct children
intersail.nav.NodeElement = class NodeElement extends intersail.lib.Model
  constructor: (@id, @label = "", @sibling = null, @children = null, @parent = null) ->

  allAttributes: ()->
    allAttributes = [@attributes]
    current = @
    while current.parent
      allAttributes.push(current.parent.attributes) if current.parent.attributes
      current = current.parent
    allAttributes.reverse()

  getRightSiblingAtIndex: (index = 0) ->
    sibling = this
    while index >= 0
      sibling = sibling.sibling
      index--
    sibling

  getRightSiblings: ->
    @siblings = []
    sibling = @sibling
    while sibling
      @siblings.push(sibling)
      sibling = sibling?.sibling ? false

    @siblings

  getSiblings: ->
    # for the root level
    unless @parent
      allSiblings = @root.getRightSiblings()
      allSiblings.push(@root)
    else
      allSiblings = @parent.children.getRightSiblings()
      allSiblings.push(@parent.children)

    allSiblings.splice(allSiblings.indexOf(this),1)
    @siblings = allSiblings
    @siblings

  setSiblings: (siblingsArray)->
    while siblingsArray.length > 0
      current_element = this
      sibling = siblingsArray.pop()
      current_element.sibling = sibling
      current_element = current_element.sibling

  hasChildrens: ->
    return @getChildrens().length > 0

  hasSiblingWithChildrens: ->
    for sibling in @getSiblings()
      return true if sibling.hasChildrens()
    return false

  # return all the first level childrens
  getChildrens: ->
    @childrens = []
    children = @children
    while children
      @childrens.push(children)
      children = children.sibling

    @childrens

  # set all the elements as childrens
  setChildrens: (childrensArray) ->
    return if childrensArray.length <= 0
    @children = childrensArray.pop()
    @children.setSiblings(childrensArray)

  getParents: (parents = [], node = @.parent) ->
      parents.push(node) if node
      @getParents(parents, node.parent) if node?.parent
      parents

  isLeaf: ->
    ! (@hasChildrens() || @hasSiblingWithChildrens())

  isElement: ->
    ! @isDir()

  isDir: ->
    @hasChildrens()