# Lib

#= require ../../lib/js/jquery-1.7.1.min.js
#= require ../../lib/js/jquery-ui-1.8.16.custom.min.js
#= require_tree ../../lib/js/

# App
# TODO: move each module's coffeescript to it's own file

# Clock
$ ->
  $clock = $(".now")
  clock_tick = ->
    $clock.html(Date.create().format '{Weekday} {Month} {d}, {12hr}:{mm}{tt}')
  window.setInterval clock_tick, 1000


# Volume Control
$ ->
  $volumeContainer = $(".volume-level")
  $volume = $(".volume-level-progress")
  $volumeLevelIndicator = $volume.find(".bar")

  setVolumeLevel = (level) =>
    $volumeLevelIndicator.css "width", "#{level}px"

  # The volume up and down icons turn the volume to full and mute respectively
  $volumeContainer.find(".icon-volume-up").click => setVolumeLevel($volume.innerWidth())
  $volumeContainer.find(".icon-volume-down").click => setVolumeLevel(0)

  # Clicking the progress bar sets the volume to the clicked level
  $volume.click (e) => setVolumeLevel e.offsetX

# Music Player
# TODO


# Browse Music
$ ->
  $(".songs-list").on "click", "tr", (e) ->
    console.log e
    $(e.delegateTarget).find("tr.selected").removeClass("selected")
    $(e.currentTarget).addClass("selected")


# Navigation
$ ->
  $(".home-btn").click -> $(".pages").attr "class", "pages show-page-0"
  $(".page-0 .buttons .btn").click (e) ->
    pageId = $(".page-0 .buttons .btn").index(e.target) + 1
    console.log(pageId)
    $(".pages").attr("class", "pages show-page-#{pageId}")


# News
$ ->
  $newsModal = $('#newsModal').modal("hide")
  $(".article").on "click", "a.news-more", (e) ->
    title = $(e.delegateTarget).find("h2").html()
    description = $(e.delegateTarget).data("content")
    $newsModal.find("h3").html(title)
    $newsModal.find("p").html(description)
    $newsModal.modal('show')
