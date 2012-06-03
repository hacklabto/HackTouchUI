# Helper methods defined here can be accessed in any controller or view in the application

App.helpers do
  # def simple_helper_method
  #  ...
  # end
  
  # Chim's code 
  # I don't know where's the model in padrino
  # So I'm adding a method into the helper which is not that great. I know.
  # I'm creating a weather method which will be called directly from the view
  
  def load_weatherman
    client_weather = Weatherman::Client.new             # I'm calling the weather gem class
    @weather_response = client_weather.lookup_by_woeid 4118      # 4118 is the city id from Yahoo weather
    @weather_condition_yahoo_code = @weather_response.condition['code']      # Check http://developer.yahoo.com/weather/#codes
    @weather_forecast = @weather_response.forecasts;
  end
  
  # Temperature:
  def weather_temp_current
    load_weatherman
    return @weather_response.condition['temp']
  end
 
   def weather_temp_today_high
    load_weatherman
    return @weather_forecast.first['high']
  end
  
  def weather_temp_tomorrow_high
    load_weatherman
    return @weather_forecast[1]['high']
  end
  
  def weather_temp_today_low
    load_weatherman
    return @weather_forecast.first['low']
  end
  
  def weather_temp_tomorrow_low
    load_weatherman
    return @weather_forecast[1]['low']
  end
  
 # Condition (Text)
  def weather_condition_current
    load_weatherman
    return @weather_response.condition['text']
  end

  def weather_condition_today
    load_weatherman
    return @weather_forecast.first['text']
  end
  
  def weather_condition_tomorrow
    load_weatherman
    return @weather_forecast[1]['text']
  end


 # Icons:
  def show_weather_icon_current
    load_weatherman
    code = @weather_response.condition['code'].to_i
    return show_weather_icon(code) 
  end
 
 
  def show_weather_icon_today
    load_weatherman
    code = @weather_forecast[0]['code'].to_i
    return show_weather_icon(code) 
  end
  
  def show_weather_icon_tomorrow
    load_weatherman
    code = @weather_forecast[1]['code'].to_i
    return show_weather_icon(code) 
  end
   
  # Misc:
  def weather_tomorrow_text
    return @weather_forecast[1]['day']
  end
  
  def weather_windspeed
    return @weather_response.wind['speed']
  end
   
  def weather_humidity
    return @weather_response.atmosphere['humidity']
  end
   
  # Weather Icon Mapping
  def show_weather_icon(code)
    case code
      when 0
        "heavy-storm"
      when 1
        "heavy-storm"        
      when 2
        "heavy-storm" 
      when 3
        "heavy-storm-night" 
      when 4
        "heavy-storm-day" 
      when 5
        "rain-and-snow" 
      when 6
        "rain-and-snow" 
      when 7
        "rain-and-snow" 
      when 8
        "ice-rain" 
      when 9
        "rain-day" 
      when 10
        "rain-day" 
      when 11
        "light-rain-day" 
      when 12
        "light-rain-night" 
      when 13
        "light-snow-day" 
      when 14
        "light-snow-day" 
      when 15
        "light-snow-day" 
      when 16
        "snow-day" 
      when 17
        "ice-rain" 
      when 18
        "ice-rain" 
      when 19
        "unknown" 
      when 20
        "heavy-fog-day" 
      when 21
        "heavy-fog-day" 
      when 22
        "heavy-fog-day" 
      when 23
        "heavy-fog-day" 
      when 24
        "medium-clouds-day" 
      when 25
        "clear-day" 
      when 26
        "medium-clouds-day" 
      when 27
        "medium-heavy-clouds-night" 
      when 28
        "medium-heavy-clouds-day" 
      when 29
        "medium-clouds-night" 
      when 30
        ".medium-clouds-day" 
      when 31
        "clear-night" 
      when 32
        "clear-day" 
      when 33
        "clear-night" 
      when 34
        "clear-day" 
      when 35
        "ice-rain" 
      when 36
        "clear-day" 
      when 37
        "heavy-storm-day" 
      when 38
        "rain-day" 
      when 39
        "rain-day" 
      when 40
        "rain" 
      when 41
        "heavy-snow" 
      when 42
        "snow-day" 
      when 43
        "extra-heavy-snow" 
      when 44
        "medium-clouds-day" 
      when 45
        "rain" 
      when 46
        "snow-day" 
      when 47
        "rain" 
      when 3200
        "meow" 
      else
        "meow" 
    end
  end
  
end
