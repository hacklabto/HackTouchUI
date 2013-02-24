$ ->
  $clock = $(".now")
  clockTick = ->
    $clock.text(Date.create().format '{Weekday} {Month} {d}, {12hr}:{mm}{tt}')

  window.setInterval clockTick, 1000
