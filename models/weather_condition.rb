class WeatherCondition
  def initialize(condition_or_forecast, wind = nil, atmosphere = nil)
    @data = condition_or_forecast
    @wind = wind
    @atmosphere = atmosphere
  end

  def is_forecast?
    @wind.nil?
  end

  def code
    @data['code'].to_i
  end

  def temp
    @data['temp']
  end

  def high
    @data['high']
  end

  def low
    @data['low']
  end

  def text
    @data['text']
  end

  def windspeed
    @wind['speed']
  end

  def humidity
    @atmosphere['humidity']
  end

  def day
    @data['day']
  end

  def icon
    case code
      when 0, 1, 2
        "heavy-storm"
      when 3
        "heavy-storm-night"
      when 4
        "heavy-storm-day"
      when 5, 6, 7
        "rain-and-snow"
      when 8
        "ice-rain"
      when 9, 10
        "rain-day"
      when 11
        "light-rain-day"
      when 12
        "light-rain-night"
      when 13, 14, 15
        "light-snow-day"
      when 16
        "snow-day"
      when 17, 18
        "ice-rain"
      when 19
        "unknown"
      when 20, 21, 22, 23
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
      when 31, 33
        "clear-night"
      when 32, 34
        "clear-day"
      when 35
        "ice-rain"
      when 36
        "clear-day"
      when 37
        "heavy-storm-day"
      when 38, 39
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
      else
        "meow"
    end
  end

  def to_hash
    basics = {
      :icon => icon,
      :condition => text,
    }
    if is_forecast?
      details = {
        :day => day,
        :temp_high => high,
        :temp_low => low,
      }
    else
      details = {
        :temp => temp,
        :windspeed => windspeed,
        :humidity => humidity,
      }
    end
    basics.merge details
  end
end
