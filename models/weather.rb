class Weather
  def initialize(location=4118) # toronto
    client = Weatherman::Client.new
    @weather_response = client.lookup_by_woeid location
  end

  def response
    @weather_response
  end

  def now
    WeatherCondition.new response.condition, response.wind, response.atmosphere
  end

  def today
    WeatherCondition.new response.forecasts.first
  end

  def tomorrow
    WeatherCondition.new response.forecasts[1]
  end
end
