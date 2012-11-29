###
# Execute Method
# (c) 2012 Leif Ringstad
# Licensed under the freeBSD license (see LICENSE.txt for details)
#
# Source: http://github.com/leifcr/execute_method
# v 1.0.0
###

ExecuteMethod =
  getFunctionsAndProperties: (str) ->
    # console.log"getFunctionsAndProperties"
    arr = str.split(".")
    i = 0
    ret = []
    while i < arr.length
      ret.push ExecuteMethod.getFunctionAndParameters(arr[i])
      i++
    # console.log ret
    ret

  getFunctionAndParameters: (str) ->
    # console.log "getFunctionAndParameters"
    if ExecuteMethod.isFunction(str)
      params = str.substring(str.indexOf("(")+1, str.indexOf(")"))
      if params.length > 0
        params = ExecuteMethod.splitAndTypeCastParameters(params)
      else
        params = []
      func = str.substring(0, str.indexOf ("\(") )
      isfunc = true
    else 
      func = str
      params = null
      isfunc = false

    {func: func, params: params, isfunc: isfunc}

  splitAndTypeCastParameters: (params) ->
    # console.log"splitAndTypeCastParameters"
    arr = params.split(",")
    ret = []
    i = 0
    ret = []
    while i < arr.length
      ret.push ExecuteMethod.typecastParameter(arr[i])
      i++
    ret

  isFunction: (str) ->
    # console.log "isFunction"
    if ExecuteMethod.regexIndexOf(str, /(\([\d|\D]+\))|(\(\))/, 0) != -1
      return true
    false

  regexIndexOf: (string, regex, startpos) ->
    # console.log "regexIndexOf"
    indexOf = string.substring(startpos || 0).search(regex);
    if (indexOf >= 0) then (indexOf + (startpos || 0)) else indexOf;

  typecastParameter: (param) ->
    param = param.trim()
    param = param.replace(/^"/, "")
    param = param.replace(/"$/m, "")
    if param.search(/^\d+$/) == 0
      # only numbers, parse to integer
      return parseInt(param)
    else if param.search(/^\d+\.\d+$/) == 0
      return parseFloat(param)
    else if param == "false" 
      return false
    else if param == "true"
      return true

    param # just return the param as a string otherwise

  executeSingleFunction: (func, params, context, _that) ->
    context[func].apply(_that, params)

  getSingleProperty: (property, context) ->
    context[property]

  ###
  # @param {String} Provide a string on what to execute (e.g. this.is.something(true).to_run() or myFunction().property or myFunction())
  # @param {Object} Provide a object to run the string provided on
  # @param {Object} Provide an object that points to the "this" pointer which 
  ###
  executeMethodByFunctionName: (str, context) ->
    func_data = ExecuteMethod.getFunctionsAndProperties(str)
    # since it's possible to chain functions and/or properties, and it's not possible to chain properly do a loop
    i = 0
    current_context = context
    current_val = null
    while i < func_data.length
      if (func_data[i]["isfunc"] == true)
        current_context = ExecuteMethod.executeSingleFunction(func_data[i]["func"], func_data[i]["params"], current_context, context)
      else
        current_context = ExecuteMethod.getSingleProperty(func_data[i]["func"], current_context)
      i++
    current_context

if (!String.prototype.trim)
  String.prototype.trim = ->
    this.replace(/^\s+|\s+$/g,'');

if (window.ExecuteMethod == "undefined" || window.ExecuteMethod == null || window.ExecuteMethod == undefined)
  window.ExecuteMethod = ExecuteMethod