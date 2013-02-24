# Volume Control
$ ->
  $volumeContainer = $(".volume-level")
  $volume = $(".volume-level-progress")
  $volumeLevelIndicator = $volume.find(".bar")

  setVolumeLevel = (level) ->
    $volumeLevelIndicator.css "width", "#{level}px"
    real_level = level* 100 / $volume.innerWidth() ;
    $.post '/audio/set_volume',
      volume: "#{Math.round(real_level)}"

  # The volume up and down icons turn the volume to full and mute respectively
  $volumeContainer.find(".icon-volume-up").click -> setVolumeLevel($volume.innerWidth())
  $volumeContainer.find(".icon-volume-down").click -> setVolumeLevel(0)

  # Clicking the progress bar sets the volume to the clicked level
  $volume.click (e) -> setVolumeLevel e.offsetX


# Browse Music + Music Player
$ ->
  titleUpdater = ->
    $.get '/audio/is_playing', (data) ->
      if data == "1"
        $.get '/audio/now_playing', (data) ->
          $(".song-name").html(data)
      else
        $(".song-name").html("Not Playing");

  window.setInterval titleUpdater, 10000

  stream_list=[]
  $.get '/audio/streamlist', (data) ->
    stream_list = data
    $.each data, (key,value) ->
      $(".audio_streams tbody").append("<tr><td>"+key+"</td></tr>")

  $(".audio_streams tbody").on "click", "tr", (e) ->
    $(e.delegateTarget).find("tr.selected").removeClass("selected")
    $(e.currentTarget).addClass("selected")
    $.post '/audio/add_stream',
      source: stream_list[$(e.target).html()]
    $(".song-name").html("Loading...")

# Music Controls:

  $(".audio-play").click ->
    $.post '/audio/play'
    $(".song-name").html("Loading...")

  $(".audio-stop").click ->
    $.post '/audio/stop'
    $(".song-name").html("Not Playing");
