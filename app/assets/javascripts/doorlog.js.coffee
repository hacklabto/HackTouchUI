# Door Log list
$ ->
  doorLogUpdater = ->
    $.getJSON "/doorlog", (data) ->
      $(".door-log-list tr").each (ind, elem) ->
        $(elem).find(".username").text(data[ind].nick)
        $(elem).find(".total-entries").text(data[ind].entry_count + " entries to date")
        $(elem).find(".date).text(data[ind].logged)
  
  window.setInterval doorLogUpdater, 10000
