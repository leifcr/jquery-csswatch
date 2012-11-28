CssWatch = (elem, options) ->
  @elem = elem
  @$elem = $(elem)
  @options = options
  return

# the plugin prototype
CssWatch:: =
  defaults:
    event_name:        "css-change"

  init: ->
    @config = $.extend({}, @defaults, @options, @metadata)
    console.log(@config)
    @
  test: ->
    console.log "test invoked"
    return

options = {cow:"cow"}

if typeof options is "object" or not options
  obj = new CssWatch(@, options)
  obj.init()
else if typeof options is "string"
  unless obj && obj[options]
    obj[options].apply

options = "test"

if typeof options is "object" or not options
  obj = new CssWatch(@, options)
  obj.init()
else if typeof options is "string"
  console.log(options)
  console.log obj[options]
  if obj && obj[options]
    obj[options].call this

