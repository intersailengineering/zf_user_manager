intersail.lib.AttrAccessor = class AttrAccessor
  get: (field) ->
    # call getter if exists
    getter = "get#{intersail.lib.ucFirst(field)}"
    return this[getter]() if (typeof this[getter] == "function")
    @attributes[field]

  set: (field, value) ->
    # call setter if exists
    setter = "set#{intersail.lib.ucFirst(field)}"
    return this[setter](value) if (typeof this[setter] == "function")
    @attributes[field]=value

  defineAttribute: (field, type) ->
    @attributes ||= {}
    prop = {}
    prop[field] = {}
    prop[field].get = () -> @get(field) unless type == "writer"
    prop[field].set = (value) -> @set(field, value) unless type == "reader"
    Object.defineProperties(@ , prop)

  attr_accessor: (field) ->
    @defineAttribute(field, "all")

  attr_reader: (field) ->
    @defineAttribute(field, "reader")

  attr_writer: (field) ->
    @defineAttribute(field, "writer")

# to include this do:
# @include intersail.lib.AttrAccessor
# then you have to put in the constructor of your class
# @attr_reader "field"
# @attr_writer "field"
# @attr_accessor "field" ...
