class intersail.lib.Model
  setAttr: (key, value) ->
    # cal setter if exists
    setter = "set#{intersail.lib.ucFirst(key)}"
    return this[setter](value) if (typeof this[setter] == "function")
    # otherwise set local attribute
    this[key] = value

  getAttr: (key) ->
    # call getter if exists
    getter = "get#{intersail.lib.ucFirst(key)}"
    return this[getter]() if (typeof this[getter] == "function")
    # otherwise set local attribute
    @[key]