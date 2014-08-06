
/*
jQuery css-watch event Coffeescript
http://github.com/leifcr/jquery-csswatch/
(c) 2012-2014 Leif Ringstad

@author Leif Ringstad

Licensed under the freeBSD license
 */
var __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

(function($, window, document) {

  /*
    Request Animation frame shim
    References
    http://www.paulirish.com/2011/requestanimationframe-for-smart-animating/
   */
  var CssWatch;
  window.cssWatchRequestAnimationFrame = (function() {
    return window.requestAnimationFrame || window.webkitAnimationFrame || window.webkitRequestAnimationFrame || window.mozRequestAnimationFrame || window.oRequestAnimationFrame || window.msRequestAnimationFrame || function(callback, element) {
      return window.setTimeout(callback, 1000 / 60);
    };
  })();
  window.cssWatchCancelAnimationFrame = (function() {
    return window.cancelAnimationFrame || window.webkitCancelAnimationFrame || window.webkitCancelRequestAnimationFrame || window.mozCancelAnimationFrame || window.mozCancelRequestAnimationFrame || window.oCancelRequestAnimationFrame || window.msCancelRequestAnimationFrame || function(timeout_id) {
      return window.clearTimeout(timeout_id);
    };
  })();

  /*
    Plugin constructor
   */
  CssWatch = function(elem, options) {
    this.elem = elem;
    this.$elem = $(elem);
    this.options = options;
    this.cb_timer_id = null;
    this.stop_requested = false;
    this.running = false;
  };

  /*
    Plugin prototype
   */
  CssWatch.prototype = {
    defaults: {
      event_name: "css-change",
      data_attr_name: "css-watch-data",
      use_event: true,
      callback: null,
      props: "",
      props_functions: {}
    },

    /*
      Initializer
     */
    init: function() {
      this.config = $.extend({}, this.defaults, this.options, this.metadata);
      this.config.props = this.splitAndTrimProps(this.config.props);
      if (this.config.props.length > 0) {
        this.setInitialData();
        this.start();
      }
      return this;
    },

    /*
      split and trim properties
     */
    splitAndTrimProps: function(props) {
      var arr, i, ret;
      props = props.trim();
      ret = [];
      if (props.length === 0) {
        return ret;
      }
      arr = props.split(",");
      i = 0;
      while (i < arr.length) {
        ret.push(arr[i].trim());
        i++;
      }
      return ret;
    },

    /*
      set initial data
     */
    setInitialData: function() {
      var i;
      i = 0;
      while (i < this.config.props.length) {
        this.setData(this.config.props[i], this.getPropertyValue(this.config.props[i]));
        i++;
      }
    },

    /*
      set a data element for a css property on the current element
     */
    setData: function(property, value) {
      return this.$elem.data("" + this.config.data_attr_name + "-" + property, value);
    },

    /*
      update data attributes from changes
     */
    updateDataFromChanges: function(changes) {
      var property, value, _i, _len, _ref;
      _ref = Object.keys(changes);
      for (value = _i = 0, _len = _ref.length; _i < _len; value = ++_i) {
        property = _ref[value];
        this.setData(property, changes[property]);
      }
    },

    /*
      remove data attribute from the element by given property
     */
    removeData: function(property) {
      return this.$elem.removeData("" + this.config.data_attr_name + "-" + property);
    },

    /*
      get the datavalue stored for a property
     */
    getDataValue: function(property) {
      return this.$elem.data("" + this.config.data_attr_name + "-" + property);
    },

    /*
      get css property value (from jquery css or from custom function if needed)
     */
    getPropertyValue: function(property) {
      var function_to_call;
      if (Object.keys(this.config.props_functions).length === 0) {
        return this.$elem.css(property);
      }
      function_to_call = null;
      if (__indexOf.call(Object.keys(this.config.props_functions), property) >= 0) {
        function_to_call = this.config.props_functions[property];
      } else {
        function_to_call === null;
      }
      if (function_to_call !== null) {
        if (window.ExecuteMethod) {
          return ExecuteMethod.executeMethodByFunctionName(function_to_call, this.$elem);
        } else {
          console.log("You are missing the ExecuteMethod library.");
        }
      }
      return this.$elem.css(property);
    },

    /*
      get object of changes
     */
    changedProperties: function() {
      var i, ret;
      i = 0;
      ret = {};
      while (i < this.config.props.length) {
        if (this.getPropertyValue(this.config.props[i]) !== this.getDataValue(this.config.props[i])) {
          ret[this.config.props[i]] = this.getPropertyValue(this.config.props[i]);
        }
        i++;
      }
      return ret;
    },

    /*
      stop csswatch / checking of css attributes
     */
    stop: function() {
      if (typeof this.config === "undefined" || this.config === null) {
        return;
      }
      this.stop_requested = true;
      this.running = false;
      return window.cssWatchCancelAnimationFrame(this.cb_timer_id);
    },

    /*
      start csswatch / checking of css attributes
     */
    start: function() {
      if (typeof this.config === "undefined" || this.config === null) {
        return;
      }
      this.stop_requested = false;
      this.running = true;
      this.cb_timer_id = window.cssWatchRequestAnimationFrame((function(_this) {
        return function() {
          _this.check();
        };
      })(this));
    },

    /*
      the actual checking of changes
     */
    check: function() {
      var changes;
      if (this.stop_requested === true) {
        return false;
      }
      if (typeof this.config === "undefined" || this.config === null) {
        return false;
      }
      changes = this.changedProperties();
      if (Object.keys(changes).length > 0) {
        if (this.config.use_event) {
          this.$elem.trigger(this.config.event_name, changes);
        }
        if (this.config.callback !== null) {
          this.config.callback.apply(null, [changes]);
        }
        this.updateDataFromChanges(changes);
      }
      this.cb_timer_id = window.cssWatchRequestAnimationFrame((function(_this) {
        return function() {
          _this.check();
        };
      })(this));
      return false;
    },

    /*
      check if the watcher is running
     */
    isRunning: function() {
      return this.running === true;
    },

    /*
     destroy plugin (stop/remove data)
     */
    destroy: function() {
      var i;
      this.stop();
      this.$elem.removeData("css-watch-object");
      i = 0;
      while (i < this.config.props.length) {
        this.removeData(this.config.props[i]);
        i++;
      }
      this.$elem.removeData(this.config.data_attr_name);
      return null;
    }
  };

  /*
   Set defaults
   */
  CssWatch.defaults = CssWatch.prototype.defaults;

  /*
   Jquery extension for plugin
   Plugin funcitonality is in the class above
   */
  $.fn.csswatch = function(options) {
    return this.each(function() {
      var data, obj;
      if (typeof options === "object" || !options) {
        data = $(this).data("css-watch-object");
        if (!data) {
          obj = new CssWatch(this, options);
          $(this).data("css-watch-object", obj);
          return obj.init();
        }
      } else if (typeof options === "string") {
        obj = $(this).data("css-watch-object");
        if (obj && obj[options]) {
          return obj[options].apply(obj);
        }
      }
    });
  };
})(jQuery, window, document);

//# sourceMappingURL=jquery-csswatch.js.map
