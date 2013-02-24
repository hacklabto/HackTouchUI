$ ->

  routes =
  spadinanorth:
    route: 510
    stopId: 6577
  spadinasouth:
    route: 510
    stopId: 3159
  collegeeast:
    route: 506
    stopId: 1010
  collegewest:
    route: 506
    stopId: 9193
  dundaseast:
    route: 505
    stopId: 6046
  dundaswest:
    route: 505
    stopId: 1212


  renderSchedule = (schedule) ->
    # Generating nice, human readable bus times
    dateStrings = for date in Object.values(schedule)[0]
      date.format('{12hr}:{mm} {tt}')
      # Relative street car schedule formatting left here for easy uncommenting in case it turns out that people hate the absolute times
      #date.relative (val,unit ) -> "#{val} #{Date.getLocale().units[unit][0..2]}"

    this.html dateStrings.join("<span class='comma'>, </span>")
    return true

  update = ->
    # Front Page
    fetchPrediction routes.spadinanorth.route, routes.spadinanorth.stopId, renderSchedule.bind $("#times")
    fetchPrediction routes.spadinasouth.route, routes.spadinasouth.stopId, renderSchedule.bind $("#timen")

    # Street cars page
    predicts = for own element,param of routes
      fetchPrediction param.route, param.stopId, renderSchedule.bind $("##{element}")

  fetchPrediction = (route, stop, callback) ->
    $.get "http://webservices.nextbus.com/service/publicXMLFeed"
      command: "predictions",
      a: "ttc",
      r: route,
      s: stop,
      (xml) ->
        schedule = {}
        $(xml).find('direction').each ->
          thisDirectionSchedule = schedule[$(this).attr('title')] = new Array()
          $(this).find('prediction').each ->
            # Pushing the epoch time of this bus to the list of buses comming in the current direction
            thisDirectionSchedule.push new Date( parseInt( $(this).attr('epochTime') ) )
        callback(schedule)

  update()
  window.setInterval update, 60000
