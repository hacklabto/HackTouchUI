# Helper methods defined here can be accessed in any controller or view in the application

App.helpers do

  def cached_news
    cache("topnews", :expires_in => 300) do
      NewsFeed.getAllArticles.first 5
    end
  end

  def cached_weather
    cache("weather", :expires_in => 300) do
      w = Weather.new
      {
        :current  => w.now,
        :today    => w.today,
        :tomorrow => w.tomorrow,
      }
    end
  end

end
