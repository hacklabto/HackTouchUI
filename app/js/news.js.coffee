# News: Testing
$ ->
  updateNews()

$ ->
  $newsModal = $('#newsModal').modal("hide")
  $(".article").on "click", "a.news-more", (e) ->
    title = $(e.delegateTarget).find("h2").html()
    content =$(e.delegateTarget).find(".news-content").html()
    source = $(e.delegateTarget).find(".news-source").html()
    $newsModal.find("h3").html(title + " From: " + source)
    $newsModal.find("p").html(content)
    $newsModal.modal('show')
