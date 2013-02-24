App.controller do

  layout :layout

  get :index do
    @news_items = cached_news
    @weather = cached_weather
    render :index
  end

  get :news, :provides => :json do
    cached_news.to_json
  end

  get :weather, :provides => :json do
    render cached_weather
  end

end
