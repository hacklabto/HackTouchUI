$ ->
  $clock = $(".now")
  clockTick = ->
    $clock.html(Date.create().format '{Weekday} {Month} {d}, {12hr}:{mm}{tt}')

  window.setInterval clockTick, 1000
