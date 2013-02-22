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


  $streetcarsUpdated = $(".streetcars-updated-timestamp")
  streetcarsTick = ->
    updated = $streetcarsUpdated.data("timestamp")
    $streetcarsUpdated.html if updated? then new Date(updated).relative() else "never"

  streetcarsTick()
  window.setInterval streetcarsTick, 15000


  renderSchedule = (schedule) ->
  #  console.log times

    # Generating nice, human readable bus times
    dateStrings = for date in Object.values(schedule)[0]
      date.format('{12hr}:{mm} {tt}')
      # Relative street car schedule formatting left here for easy uncommenting in case it turns out that people hate the absolute times
      date.relative (val,unit ) -> "#{val} #{Date.getLocale().units[unit][0..2]}"

    this.html dateStrings.join("<span class='comma'>, </span>")
    # Update the streetcars last updated ticker
    $(".streetcars-updated-timestamp").data("timestamp", Date.now())
    streetcarsTick()
    return true


  update = ->
    # Front Page - Northbound
    updatePrediction routes.spadinanorth.route, routes.spadinanorth.stopId, renderSchedule.bind $("#times")
    # Front Page - Southbound
    updatePrediction routes.spadinasouth.route, routes.spadinasouth.stopId, renderSchedule.bind $("#timen")

    # Street cars page
    predicts = for element,param of routes
      updatePrediction param.route, param.stopId, renderSchedule.bind $("##{element}")

  window.setInterval update, 60000
  
  
  update()
