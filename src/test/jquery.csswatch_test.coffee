QUnit.module 'jQuery Event Test: When testing 1 css attribute on 1 element', {
  setup: ->
    @cbcount = 0
    $('#qunit-fixture').prepend("<div class=\"testdiv\">This is the testing div</div>")
    $('.testdiv').on("css-change", (event, change) =>
      @cbcount++
      equal(Object.keys(change).length, 1, "Number of changes in single callback should be 1")
      equal(Object.keys(change)[0], "color", "Name of change should be 'color'")
    )

  teardown: ->
    $('.testdiv').remove()
    return
  }

QUnit.asyncTest '1 callback on event should be triggered and change should be on "color"', 3, ->
  $('.testdiv').csswatch({props: 'color'})
  $('.testdiv').addClass("test-color1")
  setTimeout(( =>
    equal(@cbcount, 1, "should have 1 change")
    $('.testdiv').off("css-change")
    $('.testdiv').csswatch('stop')
    start())
    , 400)
  return

QUnit.asyncTest '2 callbacks on event should be triggered and change should be on "color"', 5, ->
  @cbcount = 0
  $('.testdiv').csswatch({props: 'color'})
  setTimeout(( -> $('.testdiv').addClass("test-color1")) , 100)
  setTimeout(( -> $('.testdiv').addClass("test-color2").removeClass("test-color1")) , 200)
  setTimeout(( =>
    equal(@cbcount, 2, "should have 2 changes")
    $('.testdiv').off("css-change")
    $('.testdiv').csswatch('stop')
    start())
    ,400)
  return

QUnit.module 'jQuery Event Test: When testing 2 css attributes on 1 element', {
  setup: ->
    @cbcount = 0
    $('#qunit-fixture').prepend("<div class=\"testdiv\">This is the testing div</div>")
    $('.testdiv').on("css-change", (event, change) =>
      @cbcount++
      equal(Object.keys(change).length, 2, "Number of changes in single callback should be 2")
      equal(Object.keys(change)[0], "color", "Name of change should be 'color'")
      equal(Object.keys(change)[1], "background-color", "Name of change should be 'background-color'")
    )

  teardown: ->
    $('.testdiv').remove()
    return
}

QUnit.asyncTest '1 callback on event should be triggered and change should be on "color" and "background-color', 4, ->
  $('.testdiv').csswatch({props: 'color, background-color'})
  $('.testdiv').addClass("test-color1").addClass("test-background-color1")
  setTimeout(( =>
    equal(@cbcount, 1, "should have 1 change")
    $('.testdiv').off("css-change")
    $('.testdiv').csswatch('stop')
    start())
    ,300)
  return

QUnit.asyncTest '2 callbacks on event should be triggered and change should be on "color" and "background-color"', 7, ->
  @cbcount = 0
  $('.testdiv').csswatch({props: 'color, background-color'})
  setTimeout(( -> $('.testdiv').addClass("test-color1").addClass('test-background-color1')) , 100)
  setTimeout(( -> $('.testdiv').addClass("test-color2").removeClass("test-color1").addClass('test-background-color2').removeClass('test-background-color1')) , 200)
  setTimeout(( =>
    equal(@cbcount, 2, "should have 2 changes")
    $('.testdiv').off("css-change")
    $('.testdiv').csswatch('stop')
    start())
    ,400)
  return


QUnit.module 'jQuery Event Test: When testing 1 css attribute on 1 element with a custom function', {
  setup: ->
    @cbcount = 0
    $('#qunit-fixture').prepend("<div class=\"testdiv\">This is the testing div</div>")
    $('.testdiv').on("css-change", (event, change) =>
      @cbcount++
      equal(Object.keys(change).length, 1, "Number of changes in single callback should be 1")
      equal(Object.keys(change)[0], "top", "Name of change should be 'top'")
    )

  teardown: ->
    $('.testdiv').remove()
    return
  }

QUnit.asyncTest '1 callback on event should be triggered and change should be on "top"', 3, ->
  $('.testdiv').csswatch({props: 'top', props_functions: {"top":"offset().top"} })
  $('.testdiv').addClass("test-position1")
  setTimeout(( =>
    equal(@cbcount, 1, "should have 1 change")
    $('.testdiv').off("css-change")
    $('.testdiv').csswatch('stop')
    start())
    , 400)
  return

QUnit.module 'jQuery Event Test: When testing 2 css attributes on 1 element with a custom function', {
  setup: ->
    @cbcount = 0
    $('#qunit-fixture').prepend("<div class=\"testdiv\">This is the testing div</div>")
    $('.testdiv').on("css-change", (event, change) =>
      @cbcount++
      equal(Object.keys(change).length, 2, "Number of changes in single callback should be 2")
      equal(Object.keys(change)[0], "top", "Name of first change should be 'top'")
      equal(Object.keys(change)[1], "left", "Name of second change should be 'left'")
    )

  teardown: ->
    $('.testdiv').remove()
    return
}

QUnit.asyncTest '1 callback on event should be triggered and change should be on "top"', 4, ->
  $('.testdiv').csswatch({props: 'top,left', props_functions: {"top":"offset().top", "left":"offset().left"} })
  $('.testdiv').addClass("test-position1")
  setTimeout(( =>
    equal(@cbcount, 1, "should have 1 change")
    $('.testdiv').off("css-change")
    $('.testdiv').csswatch('stop')
    start())
    , 400)
  return

QUnit.asyncTest 'Data should be properly set on each element', 2, ->
  $('.testdiv').csswatch({props: 'top,left', props_functions: {"top":"offset().top", "left":"offset().left"} })
  equal( $('.testdiv').data().cssWatchDataTop,   $('.testdiv').offset().top, "The top position should be equal to the elements position")
  equal( $('.testdiv').data().cssWatchDataLeft,  $('.testdiv').offset().left, "The left position should be equal to the elements position")

  setTimeout(( =>
    $('.testdiv').off("css-change")
    $('.testdiv').csswatch('stop')
    start())
    , 400)
  return

QUnit.module 'jQuery Event Test: When testing 2 css attributes on 10 elements with a custom function', {
  setup: ->
    @cbcount = 0
    testdivnum = 1
    while testdivnum < 11
      $('#qunit-fixture').append("<div class=\"testdiv\">Test div #{testdivnum++}</div>")

    $('.testdiv').on("css-change", (event, change) =>
      @cbcount++
      equal(Object.keys(change).length, 2, "Number of changes in single callback should be 2")
      equal(Object.keys(change)[0], "width", "Name of first change should be 'width'")
      equal(Object.keys(change)[1], "height", "Name of second change should be 'height'")
    )

  teardown: ->
    # $('.testdiv').remove()
    return
}

QUnit.asyncTest '1 callback on each element event should be triggered and change should be on "width" and "height"', 31, ->
  $('.testdiv').csswatch({props: 'width,height', props_functions: {"width":"width()", "height":"height()"} })
  setTimeout(( ->  $('.testdiv').addClass("test-size1")), 100)
  setTimeout(( =>
    equal(@cbcount, 10, "should have 10 changes")
    $('.testdiv').off("css-change")
    $('.testdiv').csswatch('stop')
    start())
    , 400)
  return



QUnit.module 'Using direct callback: When testing 1 css attribute on 1 element', {
  setup: ->
    @changes = []
    @cbcount = 0
    $('#qunit-fixture').prepend("<div class=\"testdiv\">This is the testing div</div>")
    $('.testdiv').csswatch({props: 'color', use_event: false, callback: (change) =>
        @cbcount++
        @changes.push(change)
      })

  teardown: ->
    $('.testdiv').csswatch('stop')
    $('.testdiv').remove()
    return
}

QUnit.asyncTest '1 callback should be triggered and change should be on "color"', 3, ->
  $('.testdiv').addClass("test-color1")
  setTimeout(( =>
    equal(@cbcount, 1, "should have 1 change")
    i = 0
    while i < @changes.length
      equal(Object.keys(@changes[i]).length, 1, "Number of changes in single callback should be 1")
      equal(Object.keys(@changes[i])[0], "color", "Name of change should be 'color'")
      i++

    start())
    , 400)
  return

QUnit.asyncTest '2 callbacks should be triggered and change should be on "color"', 5, ->
  @cbcount = 0
  setTimeout(( -> $('.testdiv').addClass("test-color1")) , 100)
  setTimeout(( -> $('.testdiv').addClass("test-color2").removeClass("test-color1")) , 200)
  setTimeout(( =>
    equal(@cbcount, 2, "should have 2 changes")
    i = 0
    while i < @changes.length
      equal(Object.keys(@changes[i]).length, 1, "Number of changes in single callback should be 1")
      equal(Object.keys(@changes[i])[0], "color", "Name of change should be 'color'")
      i++

    start())
    , 400)
  return


QUnit.module 'Using direct callback AND event: When testing 1 css attribute on 1 element', {
  setup: ->
    @callback_changes  = []
    @event_changes     = []
    @cb_callback_count = 0
    @cb_event_count    = 0
    $('#qunit-fixture').prepend("<div class=\"testdiv\">This is the testing div</div>")
    $('.testdiv').csswatch({props: 'color', callback: (change) =>
        @cb_callback_count++
        @callback_changes.push(change)

      })
    $('.testdiv').on("css-change", (event, change) =>
      @cb_event_count++
      @event_changes.push(change)
    )

  teardown: ->
    $('.testdiv').csswatch('stop')
    $('.testdiv').remove()
    return
}

QUnit.asyncTest '1 callback should be triggered and change should be on "color"', 6, ->
  $('.testdiv').addClass("test-color1")
  setTimeout(( =>
    equal(@cb_callback_count, 1, "should have 1 callback change")
    equal(@cb_event_count, 1, "should have 1 event change")
    i = 0
    while i < @event_changes.length
      equal(Object.keys(@event_changes[i]).length, 1, "Number of changes in event callback should be 1")
      equal(Object.keys(@event_changes[i])[0], "color", "Name of change in event callback should be 'color'")
      equal(Object.keys(@callback_changes[i]).length, 1, "Number of changes in direct callback should be 1")
      equal(Object.keys(@callback_changes[i])[0], "color", "Name of change in direct callback should be 'color'")
      i++

    start())
    , 400)
  return
