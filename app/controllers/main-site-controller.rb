App.controller do
  layout :layout

  get "/" do
    render :index
  end
  
  get "/play" do
    "Play"
  end
  
  get "/pause" do
    "Pause"
  end
  
  get "/stop" do
    "Stop"
  end
  
# Passes weather data via json
  get "/weather" do
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
