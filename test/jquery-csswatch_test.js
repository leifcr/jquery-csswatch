QUnit.module('jQuery Event Test: When testing 1 css attribute on 1 element', {
  setup: function() {
    this.cbcount = 0;
    $('#qunit-fixture').prepend("<div class=\"testdiv\">This is the testing div</div>");
    return $('.testdiv').on("css-change", (function(_this) {
      return function(event, change) {
        _this.cbcount++;
        equal(Object.keys(change).length, 1, "Number of changes in single callback should be 1");
        return equal(Object.keys(change)[0], "color", "Name of change should be 'color'");
      };
    })(this));
  },
  teardown: function() {
    $('.testdiv').remove();
  }
});

QUnit.asyncTest('1 callback on event should be triggered and change should be on "color"', 3, function() {
  $('.testdiv').csswatch({
    props: 'color'
  });
  $('.testdiv').addClass("test-color1");
  setTimeout(((function(_this) {
    return function() {
      equal(_this.cbcount, 1, "should have 1 change");
      $('.testdiv').off("css-change");
      $('.testdiv').csswatch('stop');
      return start();
    };
  })(this)), 300);
});

QUnit.asyncTest('2 callbacks on event should be triggered and change should be on "color"', 5, function() {
  this.cbcount = 0;
  $('.testdiv').csswatch({
    props: 'color'
  });
  setTimeout((function() {
    return $('.testdiv').addClass("test-color1");
  }), 100);
  setTimeout((function() {
    return $('.testdiv').addClass("test-color2").removeClass("test-color1");
  }), 200);
  setTimeout(((function(_this) {
    return function() {
      equal(_this.cbcount, 2, "should have 2 changes");
      $('.testdiv').off("css-change");
      $('.testdiv').csswatch('stop');
      return start();
    };
  })(this)), 300);
});

QUnit.module('jQuery Event Test: When testing 2 css attributes on 1 element', {
  setup: function() {
    this.cbcount = 0;
    $('#qunit-fixture').prepend("<div class=\"testdiv\">This is the testing div</div>");
    return $('.testdiv').on("css-change", (function(_this) {
      return function(event, change) {
        _this.cbcount++;
        equal(Object.keys(change).length, 2, "Number of changes in single callback should be 2");
        equal(Object.keys(change)[0], "color", "Name of change should be 'color'");
        return equal(Object.keys(change)[1], "background-color", "Name of change should be 'background-color'");
      };
    })(this));
  },
  teardown: function() {
    $('.testdiv').remove();
  }
});

QUnit.asyncTest('should trigger 1 callback and verify change on color and background-color', 4, function() {
  $('.testdiv').csswatch({
    props: 'color, background-color'
  });
  $('.testdiv').addClass("test-color1").addClass("test-background-color1");
  setTimeout(((function(_this) {
    return function() {
      equal(_this.cbcount, 1, "should have 1 change");
      $('.testdiv').off("css-change");
      $('.testdiv').csswatch('stop');
      return start();
    };
  })(this)), 300);
});

QUnit.asyncTest('should trigger 2 callbacks and verify change on "color and background-color', 7, function() {
  this.cbcount = 0;
  $('.testdiv').csswatch({
    props: 'color, background-color'
  });
  setTimeout((function() {
    return $('.testdiv').addClass("test-color1").addClass('test-background-color1');
  }), 100);
  setTimeout((function() {
    return $('.testdiv').addClass("test-color2").removeClass("test-color1").addClass('test-background-color2').removeClass('test-background-color1');
  }), 200);
  setTimeout(((function(_this) {
    return function() {
      equal(_this.cbcount, 2, "should have 2 changes");
      $('.testdiv').off("css-change");
      $('.testdiv').csswatch('stop');
      return start();
    };
  })(this)), 300);
});

QUnit.module('jQuery Event Test: testing 1 css attribute on 1 element with a custom function', {
  setup: function() {
    this.cbcount = 0;
    $('#qunit-fixture').prepend("<div class=\"testdiv\">This is the testing div</div>");
    return $('.testdiv').on("css-change", (function(_this) {
      return function(event, change) {
        _this.cbcount++;
        equal(Object.keys(change).length, 1, "Number of changes in single callback should be 1");
        return equal(Object.keys(change)[0], "top", "Name of change should be 'top'");
      };
    })(this));
  },
  teardown: function() {
    $('.testdiv').remove();
  }
});

QUnit.asyncTest('1 callback on event should be triggered and change should be on "top"', 3, function() {
  $('.testdiv').csswatch({
    props: 'top',
    props_functions: {
      "top": "offset().top"
    }
  });
  $('.testdiv').addClass("test-position1");
  setTimeout(((function(_this) {
    return function() {
      equal(_this.cbcount, 1, "should have 1 change");
      $('.testdiv').off("css-change");
      $('.testdiv').csswatch('stop');
      return start();
    };
  })(this)), 300);
});

QUnit.module('jQuery Event Test: testing 2 css attributes on 1 element with a custom function', {
  setup: function() {
    this.cbcount = 0;
    $('#qunit-fixture').prepend("<div class=\"testdiv\">This is the testing div</div>");
    return $('.testdiv').on("css-change", (function(_this) {
      return function(event, change) {
        _this.cbcount++;
        equal(Object.keys(change).length, 2, "Number of changes in single callback should be 2");
        equal(Object.keys(change)[0], "top", "Name of first change should be 'top'");
        return equal(Object.keys(change)[1], "left", "Name of second change should be 'left'");
      };
    })(this));
  },
  teardown: function() {
    $('.testdiv').remove();
  }
});

QUnit.asyncTest('1 callback on event should be triggered and change should be on "top"', 4, function() {
  $('.testdiv').csswatch({
    props: 'top,left',
    props_functions: {
      "top": "offset().top",
      "left": "offset().left"
    }
  });
  $('.testdiv').addClass("test-position1");
  setTimeout(((function(_this) {
    return function() {
      equal(_this.cbcount, 1, "should have 1 change");
      $('.testdiv').off("css-change");
      $('.testdiv').csswatch('stop');
      return start();
    };
  })(this)), 300);
});

QUnit.asyncTest('Data should be properly set on each element', 2, function() {
  $('.testdiv').csswatch({
    props: 'top,left',
    props_functions: {
      "top": "offset().top",
      "left": "offset().left"
    }
  });
  equal($('.testdiv').data().cssWatchDataTop, $('.testdiv').offset().top, "The top position should be equal to the elements position");
  equal($('.testdiv').data().cssWatchDataLeft, $('.testdiv').offset().left, "The left position should be equal to the elements position");
  setTimeout((function() {
    $('.testdiv').off("css-change");
    $('.testdiv').csswatch('stop');
    return start();
  }), 300);
});

QUnit.module('Event Test: 2 css attributes on 10 elements with a custom function', {
  setup: function() {
    var testdivnum;
    this.cbcount = 0;
    testdivnum = 1;
    while (testdivnum < 11) {
      $('#qunit-fixture').append("<div class=\"testdiv\">Test div " + (testdivnum++) + "</div>");
    }
    return $('.testdiv').on("css-change", (function(_this) {
      return function(event, change) {
        _this.cbcount++;
        equal(Object.keys(change).length, 2, "Number of changes in single callback should be 2");
        equal(Object.keys(change)[0], "width", "Name of first change should be 'width'");
        return equal(Object.keys(change)[1], "height", "Name of second change should be 'height'");
      };
    })(this));
  },
  teardown: function() {}
});

QUnit.asyncTest('1 callback on each element triggers and sees change on width and height', 31, function() {
  $('.testdiv').csswatch({
    props: 'width,height',
    props_functions: {
      "width": "width()",
      "height": "height()"
    }
  });
  setTimeout((function() {
    return $('.testdiv').addClass("test-size1");
  }), 100);
  setTimeout(((function(_this) {
    return function() {
      equal(_this.cbcount, 10, "should have 10 changes");
      $('.testdiv').off("css-change");
      $('.testdiv').csswatch('stop');
      return start();
    };
  })(this)), 300);
});

QUnit.module('Using direct callback: When testing 1 css attribute on 1 element', {
  setup: function() {
    this.changes = [];
    this.cbcount = 0;
    $('#qunit-fixture').prepend("<div class=\"testdiv\">This is the testing div</div>");
    return $('.testdiv').csswatch({
      props: 'color',
      use_event: false,
      callback: (function(_this) {
        return function(change) {
          _this.cbcount++;
          return _this.changes.push(change);
        };
      })(this)
    });
  },
  teardown: function() {
    $('.testdiv').csswatch('stop');
    $('.testdiv').remove();
  }
});

QUnit.asyncTest('1 callback should be triggered and change should be on "color"', 3, function() {
  $('.testdiv').addClass("test-color1");
  setTimeout(((function(_this) {
    return function() {
      var i;
      equal(_this.cbcount, 1, "should have 1 change");
      i = 0;
      while (i < _this.changes.length) {
        equal(Object.keys(_this.changes[i]).length, 1, "Number of changes in single callback should be 1");
        equal(Object.keys(_this.changes[i])[0], "color", "Name of change should be 'color'");
        i++;
      }
      return start();
    };
  })(this)), 300);
});

QUnit.asyncTest('2 callbacks should be triggered and change should be on "color"', 5, function() {
  this.cbcount = 0;
  setTimeout((function() {
    return $('.testdiv').addClass("test-color1");
  }), 100);
  setTimeout((function() {
    return $('.testdiv').addClass("test-color2").removeClass("test-color1");
  }), 200);
  setTimeout(((function(_this) {
    return function() {
      var i;
      equal(_this.cbcount, 2, "should have 2 changes");
      i = 0;
      while (i < _this.changes.length) {
        equal(Object.keys(_this.changes[i]).length, 1, "Number of changes in single callback should be 1");
        equal(Object.keys(_this.changes[i])[0], "color", "Name of change should be 'color'");
        i++;
      }
      return start();
    };
  })(this)), 300);
});

QUnit.module('Using direct callback AND event: When testing 1 css attribute on 1 element', {
  setup: function() {
    this.callback_changes = [];
    this.event_changes = [];
    this.cb_callback_count = 0;
    this.cb_event_count = 0;
    $('#qunit-fixture').prepend("<div class=\"testdiv\">This is the testing div</div>");
    $('.testdiv').csswatch({
      props: 'color',
      callback: (function(_this) {
        return function(change) {
          _this.cb_callback_count++;
          return _this.callback_changes.push(change);
        };
      })(this)
    });
    return $('.testdiv').on("css-change", (function(_this) {
      return function(event, change) {
        _this.cb_event_count++;
        return _this.event_changes.push(change);
      };
    })(this));
  },
  teardown: function() {
    $('.testdiv').csswatch('stop');
    $('.testdiv').remove();
  }
});

QUnit.asyncTest('1 callback should be triggered and change should be on "color"', 6, function() {
  $('.testdiv').addClass("test-color1");
  setTimeout(((function(_this) {
    return function() {
      var i;
      equal(_this.cb_callback_count, 1, "should have 1 callback change");
      equal(_this.cb_event_count, 1, "should have 1 event change");
      i = 0;
      while (i < _this.event_changes.length) {
        equal(Object.keys(_this.event_changes[i]).length, 1, "Number of changes in event callback should be 1");
        equal(Object.keys(_this.event_changes[i])[0], "color", "Name of change in event callback should be 'color'");
        equal(Object.keys(_this.callback_changes[i]).length, 1, "Number of changes in direct callback should be 1");
        equal(Object.keys(_this.callback_changes[i])[0], "color", "Name of change in direct callback should be 'color'");
        i++;
      }
      return start();
    };
  })(this)), 300);
});

QUnit.module('Other functionality', {
  setup: function() {
    this.cb_event_count = 0;
    $('#qunit-fixture').prepend("<div class=\"testdiv\">This is the testing div</div>");
    return $('.testdiv').on("css-change", (function(_this) {
      return function(event, change) {
        return _this.cb_event_count++;
      };
    })(this));
  },
  teardown: function() {
    $('.testdiv').remove();
  }
});

QUnit.asyncTest('Should not start when no props are set', 1, function() {
  $('.testdiv').csswatch({
    props: ''
  });
  setTimeout((function() {
    var el;
    el = $('.testdiv')[0];
    equal($(el).data("css-watch-object").isRunning(), false, "should not have started");
    return start();
  }), 50);
});

QUnit.asyncTest('Should destroy the plugin', 2, function() {
  $('.testdiv').csswatch({
    props: 'color'
  });
  setTimeout((function() {
    return $('.testdiv').addClass("test-color1");
  }), 100);
  setTimeout((function() {
    return $('.testdiv').csswatch('destroy');
  }), 200);
  setTimeout(((function(_this) {
    return function() {
      $('.testdiv').removeClass("test-color1");
      equal(_this.cb_event_count, 1, "Should only have triggered callback once");
      equal($('.testdiv').data("css-watch-data-color"), void 0, "Data value for color should be undefined after destruction");
      return start();
    };
  })(this)), 300);
});

//# sourceMappingURL=jquery-csswatch_test.js.map
