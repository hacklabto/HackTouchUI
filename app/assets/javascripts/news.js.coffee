$ ->
  $.get "/news", (data) ->
    update_news = (index, news_item) ->
      for own property, value of news_item
        $("news-#{property}-#{index}").html(value)

    for own index, news_item of data
      update_news(index, news_item)

    update_news('home', data[0])

$ ->
  $newsModal = $('#newsModal').modal("hide")
  $(".article").on "click", "a.news-more", (e) ->
    title = $(e.delegateTarget).find("h2").html()
    content =$(e.delegateTarget).find(".news-content").html()
    source = $(e.delegateTarget).find(".news-source").html()
    $newsModal.find("h3").html(title + " From: " + source)
    $newsModal.find("p").html(content)
    $newsModal.modal('show')
