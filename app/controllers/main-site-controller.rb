App.controller do
  layout :layout

  get "/" do
    render :index
  end
  
  
  get "/streamlist" do
    "#{stream_list.to_json}"
  end
  
  
  get "/add_stream" do
    $mpd.playlist_add(params[:source]);
    ""
  end
  
  get "/now_playing" do
    resp = $mpd.now_playing;
    "#{resp}"
  end
  
  get "/is_playing" do
    resp = $mpd.playing?;
    "#{resp}"
  end
  
  get "/play"  do
    $mpd.play;
    "";
  end
  
  get "/stop" do
    $mpd.stop;
    "";
  end
  
  get "/set_volume" do
    $mpd.set_volume(params[:volume]);
    ""
  end
  
  get "/news", :cache => true do
    expires_in 300 # update every 5 minutes min...
    "#{getAllArticles.to_json}";
  end
  
# Passes weather data via json
  get "/weather", :cache => true do
    expires_in 300 # Updates every 5 minutes min
    "{\"current\":
        {\"icon\":\"#{show_weather_icon_current}\",
      	\"temp\":\"#{weather_temp_current}\",
      	\"condition\":\"#{weather_condition_current}\",
      	\"windspeed\":\"#{weather_windspeed}\",
      	\"humidity\":\"#{weather_humidity}\"},
      	\"today\":
      	{\"icon\":\"#{show_weather_icon_today}\",
        \"condition\":\"#{weather_condition_today}\",
    	\"temp_high\":\"#{weather_temp_today_high}\",
    	\"temp_low\":\"#{weather_temp_today_low}\"},
    \"tomorrow\":
    	{\"icon\":\"#{show_weather_icon_tomorrow}\",
        \"day\":\"#{weather_tomorrow_text}\",    
        \"condition\":\"#{weather_condition_tomorrow}\",
    	\"temp_high\":\"#{weather_temp_tomorrow_high}\",
    	\"temp_low\":\"#{weather_temp_tomorrow_low}\"}}"
  end
  
end
