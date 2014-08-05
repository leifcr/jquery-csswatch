###
jQuery css-watch event Coffeescript
http://github.com/leifcr/jquery-csswatch/
(c) 2012-2014 Leif Ringstad

@author Leif Ringstad

Licensed under the freeBSD license
###

# Note that with this pattern, as per Alex Sexton's, the plugin logic
# hasn't been nested in a jQuery plugin. Instead, we just use
# jQuery for its instantiation.

(($, window, document) ->

  ###
    Plugin constructor
  ###
  CssWatch = (elem, options) ->
    @elem = elem
    @$elem = $(elem)
    @options = options
    @cb_timer_id = null
    @stop_requested = false
    return

  ###
    Plugin prototype
  ###
  CssWatch:: =
    defaults:
      event_name:        "css-change"
      data_attr_name:    "css-watch-data"
      use_event:         true
      callback:          null
      props:             ""
      props_functions:   {}


    ###
      Initializer
    ###
    init: ->
      @config = $.extend({}, @defaults, @options, @metadata)
      @config.props = @splitAndTrimProps(@config.props)
      if @config.props.length > 0
        @setInitialData()
        @start()

      @

    ###
      split and trim properties
    ###
    splitAndTrimProps: (props) ->
      arr = props.split(",")
      ret = []
      i = 0
      while i < arr.length
        ret.push arr[i].trim()
        i++
      ret

    ###
      set initial data
    ###
    setInitialData: ->
      i = 0
      while i < @config.props.length
        @setData @config.props[i], @getPropertyValue(@config.props[i])
        i++
      return

    ###
      set a data element for a css property on the current element
    ###
    setData: (property, value) ->
      @$elem.data("#{@config.data_attr_name}-#{property}", value)

    ###
      update data attributes from changes
    ###
    updateDataFromChanges: (changes) ->
      @setData property, changes[property] for property, value in Object.keys(changes)
      return

    ###
      get the datavalue stored for a property
    ###
    getDataValue: (property) ->
      @$elem.data("#{@config.data_attr_name}-#{property}")

    ###
      get css property value (from jquery css or from custom function if needed)
    ###
    getPropertyValue: (property) ->
      return @$elem.css(property) if (Object.keys(@config.props_functions).length == 0)

      function_to_call = null
      if property in Object.keys(@config.props_functions)
        function_to_call = @config.props_functions[property]
      else
        function_to_call == null

      if function_to_call != null
        if (window.ExecuteMethod)
          return ExecuteMethod.executeMethodByFunctionName(function_to_call, @$elem)
        else
          console.log "You are missing the ExecuteMethod library."
      # Return css value if no function found.
      @$elem.css(property)

    ###
      get object of changes
    ###
    changedProperties: ->
      i = 0
      ret = {}
      while i < @config.props.length
        if (@getPropertyValue(@config.props[i]) != @getDataValue(@config.props[i]))
          ret[@config.props[i]] = @getPropertyValue(@config.props[i])
        i++
      ret

    ###
      stop csswatch / checking of css attributes
    ###
    stop: ->
      return if (typeof @config == "undefined" || @config == null)
      @stop_requested = true
      # stop the timer/windowanimate cb for this object
      window.cssWatchCancelAnimationFrame(@cb_timer_id)


    ###
      start csswatch / checking of css attributes
    ###
    start: ->
      return if (typeof @config == "undefined" || @config == null)
      @stop_requested = false
      # start the timer/windowanimate cb for this object if it isn't running
      @cb_timer_id = window.cssWatchRequestAnimationFrame(=> @check(); return)
      return

    ###
      the actual checking of changes
    ###
    check: ->
      return false if (typeof @config == "undefined" || @config == null)
      return false if @stop_requested == true
      changes = @changedProperties()

      if (Object.keys(changes).length > 0)
        if @config.use_event
          @$elem.trigger(@config.event_name, changes)

        if @config.callback != null
          @config.callback.apply(null, [changes])
          # @config.callback.call({changes})
        # set new data for each changed property
        @updateDataFromChanges(changes)

      @cb_timer_id = window.cssWatchRequestAnimationFrame(=> @check(); return)
      false

    ###
     destroy plugin (stop/remove data)
    ###
    destroy: ->
      @stop()
      @$elem.removeData("css-watch-object")
      @$elem.removeData(@config.data_attr_name)
      @$elem.removeData("removed data_attr_name")
      return null

  ###
   Set defaults
  ###
  CssWatch.defaults = CssWatch::defaults

  ###
   Jquery extension for plugin
   Plugin funcitonality is in the class above
  ###
  $.fn.csswatch = (options) ->
    @each ->
      if typeof options is "object" or not options
        # check if there is an object existing, if so, delete it!
        data = $(@).data("css-watch-object")
        unless data
          obj = new CssWatch(@, options)
          $(@).data("css-watch-object", obj)
          obj.init()
        return
      else if typeof options is "string"
        obj = $(@).data("css-watch-object")
        if obj && obj[options]
          obj[options].apply obj

  return

  #optional: window.Plugin = Plugin;

) jQuery, window, document


###
  Cross browser requestAnimationFrame
  Not including settimeout as it will have a static value for timeout
###

unless window.cssWatchRequestAnimationFrame
  window.cssWatchRequestAnimationFrame = (->
    window.requestAnimationFrame or
    window.webkitAnimationFrame or
    window.webkitRequestAnimationFrame or
    window.mozRequestAnimationFrame or
    window.oRequestAnimationFrame or
    window.msRequestAnimationFrame or
    (callback, element) ->
      window.setTimeout(callback, 1000/60)
  )()

###
  Cross browser cancelAnimationFrame
###
unless window.cssWatchCancelAnimationFrame
  window.cssWatchCancelAnimationFrame = (->
    window.cancelAnimationFrame or
    window.webkitCancelAnimationFrame or
    window.webkitCancelRequestAnimationFrame or
    window.mozCancelAnimationFrame or
    window.mozCancelRequestAnimationFrame or
    window.oCancelRequestAnimationFrame or
    window.msCancelRequestAnimationFrame or
    (timeout_id) -> # function FrameRequestCallback
      window.clearTimeout timeout_id
  )()
