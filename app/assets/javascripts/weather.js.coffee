$ ->
  weatherupdate = ->
    $.get "/weather", (data) ->
      for own forecast in data
        for own key, value in data[forecast]
          $element = $("##{forecast}_#{key}")
          if (key != "icon")
            $element.html(value)
          else
            $element.class("icon " + value)

  weatherupdate()
  window.setInterval weatherupdate, 600000
