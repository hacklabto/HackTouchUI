App.controller :audio do

  get "/streamlist", provides: :json do
    render Hash[AudioStream.all.map{|stream| [stream.name, stream.url] }]
  end

  post "/add_stream" do
    $mpd.playlist_add params[:source]
    ""
  end

  get "/now_playing" do
    resp = $mpd.now_playing
    "#{resp}"
  end

  get "/is_playing" do
    resp = $mpd.playing?
    "#{resp}"
  end

  post "/play"  do
    $mpd.play
    ""
  end

  post "/stop" do
    $mpd.stop
    ""
  end

  post "/set_volume" do
    $mpd.set_volume params[:volume]
    ""
  end

end
