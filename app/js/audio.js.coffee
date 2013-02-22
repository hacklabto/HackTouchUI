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

