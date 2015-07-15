intersail.lib.shared.Share = class Shared
  instance = null

  constructor: ->
    if instance
      return instance
    else
      instance = this
