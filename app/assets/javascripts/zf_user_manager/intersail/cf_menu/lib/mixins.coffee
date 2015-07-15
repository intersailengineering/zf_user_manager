mixins =
  bootstrap: ->
    Function::include = (mixin) ->
      __ = intersail.__

      if not mixin
        return throw 'Supplied mixin was not found'

      if not __
        return throw 'Underscore was not found'

      mixin = mixin.prototype if __.isFunction(mixin)

      # Make a copy of the superclass with the same constructor and use it instead of adding functions directly to the superclass.
      if @.__super__
        tmpSuper = __.extend({}, @.__super__)
        tmpSuper.constructor = @.__super__.constructor

      @.__super__ = tmpSuper || {}

      # Copy function over to prototype and the new intermediate superclass.
      for methodName, funct of mixin when methodName not in ['included']
        @.__super__[methodName] = funct

        if not @prototype.hasOwnProperty(methodName)
          @prototype[methodName] = funct

      mixin.included?.apply(this)
      this

#activate mixins
mixins.bootstrap()