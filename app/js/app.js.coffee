# Lib


#= require ../../lib/js/jquery-1.7.1.min.js
#= require ../../lib/js/jquery-ui-1.8.16.custom.min.js
#= require_tree ../../lib/js/

# App
# TODO: move each module's coffeescript to it's own file

$ -> 
  $("html").mousedown (e) ->
    e.stopPropagation()
    e.preventDefault()
    false

# Clock
$ ->
  $clock = $(".now")
  clockTick = ->
    $clock.html(Date.create().format '{Weekday} {Month} {d}, {12hr}:{mm}{tt}')

  window.setInterval clockTick, 1000

# StreetCar
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
      #date.relative (val,unit ) -> "#{val} #{Date.getLocale().units[unit][0..2]}"

    this.html dateStrings.join("<span class='comma'>, </span>")
    # Update the streetcars last updated ticker
    $(".streetcars-updated-timestamp").data("timestamp", Date.now())
    streetcarsTick()
    return true


  update = ->
    # Front Page - Northbound
    updatePrediction 510, 3159, renderSchedule.bind $("#times")
    # Front Page - Southbound
    updatePrediction 510, 6577, renderSchedule.bind $("#timen")

    # Street cars page
    predicts = for element,param of routes
      updatePrediction param.route, param.stopId, renderSchedule.bind $("##{element}")

  window.setInterval update, 60000
  
  
  update()

# News: Testing
$ ->
  updateNews()

# Weather Updates:
# Auto every 10 minutes
$ ->
  weatherupdate = ->
    weatherUpdate()
  window.setInterval weatherupdate, 600000

#Cats
$ ->
  getKitten()
  $(".draw-btn").click -> getKitten()


# Volume Control
$ ->
  $volumeContainer = $(".volume-level")
  $volume = $(".volume-level-progress")
  $volumeLevelIndicator = $volume.find(".bar")

  setVolumeLevel = (level) =>
    $volumeLevelIndicator.css "width", "#{level}px"
    real_level = level* 100 / $volume.innerWidth() ;
    $.ajax '/set_volume',
      type: 'GET',
      dataType: 'html',
      data: { 'volume': "#{Math.round(real_level)}"}


  # The volume up and down icons turn the volume to full and mute respectively
  $volumeContainer.find(".icon-volume-up").click => setVolumeLevel($volume.innerWidth())
  $volumeContainer.find(".icon-volume-down").click => setVolumeLevel(0)

  # Clicking the progress bar sets the volume to the clicked level
  $volume.click (e) => setVolumeLevel e.offsetX


# Browse Music + Music Player
$ ->
  playing = 0;
  titleUpdater = ->
    $.ajax '/is_playing',
      type: 'GET',
      dataType: 'html',
      success: (data) ->
        if data == "1"
          playing = 1;
    
    if playing == 1
      $.ajax '/now_playing',
        type: 'GET',
        dataType: 'html',
        success: (data) ->
          $(".song-name").html(data)
    else
      $(".song-name").html("Not Playing");
  window.setInterval titleUpdater, 10000

  stream_list="";
  $.ajax '/streamlist',
    type: 'GET',
    dataType: 'json',
    success: (data) ->
      stream_list = data
      $.each data, (key,value) ->
        $(".audio_streams").append("<tr><td>"+key+"</td></tr>")
        
  $(".songs-list").on "click", "tr", (e) ->
    console.log $(e.target).html()
    console.log stream_list[$(e.target).html()]
    $(e.delegateTarget).find("tr.selected").removeClass("selected")
    $(e.currentTarget).addClass("selected")
    # Load new Stream instantly.
    $.ajax '/add_stream',
      type: 'GET',
      data: {'source': stream_list[$(e.target).html()]},
      dataType: 'html'
      success: (data) ->
        console.log(data)
    $(".song-name").html("Loading...")

# Music Controls:

  $("#play").click ->
    $.ajax '/play',
      type: 'GET',
      dataType: 'html'
    $(".song-name").html("Loading...")
          
  $("#stop").click ->
    $.ajax '/stop',
      type: 'GET',
      dataType: 'html'
    $(".song-name").html("Not Playing");


# Navigation
$ ->
  num_pages=7
  $(".buttons .btn").click (e) ->
    if $(".buttons .btn").index(e.target) > -1
      pageId = $(".buttons .btn").index(e.target) % num_pages
      console.log(pageId)
      $(".pages").attr("class", "pages show-page-#{pageId}")


# News
$ ->
  $newsModal = $('#newsModal').modal("hide")
  $(".article").on "click", "a.news-more", (e) ->
    title = $(e.delegateTarget).find("h2").html()
    content =$(e.delegateTarget).find(".news-content").html()
    source = $(e.delegateTarget).find(".news-source").html()
    $newsModal.find("h3").html(title + " From: " + source)
    $newsModal.find("p").html(content)
    $newsModal.modal('show')
