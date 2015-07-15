root = exports ? this

#intialize intersail app
root.intersail = {}
intersail = root.intersail
#init namespace
intersail.lib = {}

#setup alias for underscore.js
intersail.__ = root._

###
# shared constants definition
###
intersail.lib.const = {}

# keymap
intersail.lib.const.keymap = {}
intersail.lib.const.keymap.escapeKeyCode = 27

###
# singletons
###
intersail.lib.shared = {}