$ ->
  $('#watch-me-grow').on("css-change", (event, change) =>
    $(".output_grow").text("I'm growing: width: #{change.width} height: #{change.height} ");
  )
  $('#watch-me-grow').csswatch({props: 'width,height', props_functions: {"width":"width()", "height":"height()"} })

  $('#watch-me-move').on("css-change", (event, change) =>
    $(".output_position").text("I'm moving: top: #{change.top} left: #{change.left} ");
  )
  $('#watch-me-move').csswatch({props: 'top,left', props_functions: {"top":"offset().top", "left":"offset().left"} })

  $('#watch-me-change-colors').on("css-change", (event, change) =>
    $(".output_colors").text("I got some new colors: #{JSON.stringify(change)}");
  )

  $('#watch-me-change-colors').csswatch({props: 'color,background-color'})

  $('#do-grow').click( ->
    if ($('#watch-me-grow').width() < 200)
      $('#watch-me-grow').animate({'width':'200px','height':'200px'}, 500);
      $('#do-grow').text('Click to shrink the box below');
    else
      $('#watch-me-grow').animate({'width':'100px','height':'100px'}, 500);
      $('#do-grow').text('Click to grow the box below');
    return false
  )

  $('#do-move').click(->
    if ($('#watch-me-move').position().left < 50)
      $('#watch-me-move').animate({'top':'100px','left':'200px'}, 500);
      $('#do-move').text('Click to move the box below back');
    else
      $('#watch-me-move').animate({'top':'10px','left':'10px'}, 500);
      $('#do-move').text('Click to move the box below');
    return false
  )

  random_tofivefive = ->
    Math.floor((Math.random()*255)+1);

  random_color = ->
    "rgb(#{random_tofivefive()}, #{random_tofivefive()}, #{random_tofivefive()})"

  change_color = (element) ->
    element.css("color", random_color())

  change_background_color = (element) ->
    element.css("background-color", random_color())

  $('#do-change-both-colors').click( ->
    change_color($('#watch-me-change-colors'))
    change_background_color($('#watch-me-change-colors'))
    return false
  )

  $('#do-change-background-color').click( ->
    change_background_color($('#watch-me-change-colors'))
    return false
  )  

  $('#do-change-color').click( ->
    change_color($('#watch-me-change-colors'))
    return false
  )  
