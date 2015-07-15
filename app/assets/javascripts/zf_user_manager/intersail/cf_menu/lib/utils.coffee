###
# String manipulations
###
intersail.lib.ucFirst = (string) ->
  string[0].toUpperCase() + string[1..]

# To set timeout...
intersail.lib.delay = (ms, func) ->
  setTimeout func, ms
