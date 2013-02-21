# Helper methods defined here can be accessed in any controller or view in the application

App.helpers do
  
  def stream_list
    db = Sequel.connect("sqlite://#{File.dirname(__FILE__)}/../../hacktouch.sqlite3")
    stream_list = {}
    db[:audio_streams].order(:name).each do |stream|
      stream_list[stream[:name]] = stream[:url];
    end
  stream_list
  end
  
  def feed_list
    db = Sequel.connect("sqlite://#{File.dirname(__FILE__)}/../../hacktouch.sqlite3")
    stream_list = Array.new
    db[:news_feeds].order(:name).each do |stream|
      stream_list.push(stream[:url]);
    end
  stream_list
  end

  def refresh_feeds
    feeds = []
    feed_list.each do |source|
      content = ""
      feeds.push(SimpleRSS.parse open(source) )
    end
    feeds
  end

# Ugly, someone please clean this up.
# Returns 5 articles from each source, all scrambled into a random order.
  def getAllArticles
    number_from_each = 5;
    articles=Hash.new
    total=0;
    feeds = refresh_feeds; 
    random_order = (0..(feeds.length*number_from_each-1)).to_a.sort {rand}
    feeds.each do |feed|
      for i in (0..number_from_each-1)
         logger.info "Adding article #{random_order[total]}"
         articles["#{random_order[total]}"] = getArticle(feed.items[i],feed)
         total+=1
       end
    end
    articles
  end

  def getArticle(article,src)
    title = Sanitize.clean(article.title);
    source = Sanitize.clean(src.channel.title);
    content = Sanitize.clean("#{article.description}");
    desc = content.slice(0,150);
    if desc.length > 147
      desc[147..150]="..."
    end
    article = { "title" => title, "content" => content, "source" => source, "description" => desc };
    article
  end
  
  
  
  
  # Chim's code 
  # I don't know where's the model in padrino
  # So I'm adding a method into the helper which is not that great. I know.
  # I'm creating a weather method which will be called directly from the view
  # - ATrain

  # Hitting the weatherman api once per request, if this becomes high traffic this should be cached
  # (this is not very likely on the hack touch though, only sucks on dev environments because page loads are slowed by hitting the api).
  # This code works well but could do with some refactoring to combine similar code in the weather_temp_* and weather_condition_* methods
  # - Rob
  # PS. I am totally nitpicking here, lets be honest - I would never have gotten this done alone.
  # Thanks again ATrain and Geordie, this would not have happened without you guys picking up where I left off!


  def load_weatherman
    return if defined? @has_weather
    begin
      client_weather = Weatherman::Client.new             # I'm calling the weather gem class
      @weather_response = client_weather.lookup_by_woeid 4118      # 4118 is the city id from Yahoo weather
      @weather_forecast = @weather_response.forecasts
      @has_weather = true
    rescue # This gets called with the internet is down. In these cases we do not want the app to crash
      @has_weather = false
    end
  end
  
  # Temperature:
  def weather_temp_current
    load_weatherman
    return @has_weather ? @weather_response.condition['temp'] : "unavailable"
  end
 
   def weather_temp_today_high
    load_weatherman
    return @has_weather ? @weather_forecast.first['high'] : "unavailable"
  end
  
  def weather_temp_tomorrow_high
    load_weatherman
    return @has_weather ? @weather_forecast[1]['high'] : "unavailable"
  end
  
  def weather_temp_today_low
    load_weatherman
    return @has_weather ? @weather_forecast.first['low'] : "unavailable"
  end
  
  def weather_temp_tomorrow_low
    load_weatherman
    return @has_weather ? @weather_forecast[1]['low'] : "unavailable"
  end
  
 # Condition (Text)
  def weather_condition_current
    load_weatherman
    return @has_weather ? @weather_response.condition['text'] : "unavailable"
  end

  def weather_condition_today
    load_weatherman
    return @has_weather ? @weather_forecast.first['text'] : "unavailable"
  end
  
  def weather_condition_tomorrow
    load_weatherman
    return @has_weather ? @weather_forecast[1]['text'] : "unavailable"
  end


 # Icons:
  def show_weather_icon_current
    load_weatherman
    code = @has_weather ? @weather_response.condition['code'].to_i : 35
    return show_weather_icon(code) 
  end
 
 
  def show_weather_icon_today
    load_weatherman
    code = @has_weather ? @weather_forecast[0]['code'].to_i : 35
    return show_weather_icon(code) 
  end
  
  def show_weather_icon_tomorrow
    load_weatherman
    code = @has_weather ? @weather_forecast[1]['code'].to_i : 35
    return show_weather_icon(code) 
  end
   
  # Misc:
  def weather_tomorrow_text
    return @has_weather ? @weather_forecast[1]['day'] : "unavailable"
  end
  
  def weather_windspeed
    return @has_weather ? @weather_response.wind['speed'] : "unavailable"
  end
   
  def weather_humidity
    return @has_weather ? @weather_response.atmosphere['humidity'] : "unavailable"
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
        "medium-clouds-day" 
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
