# Navigation
$ ->
  num_pages=7
  $(".buttons .btn").click (e) ->
    if $(".buttons .btn").index(e.target) > -1
      pageId = $(".buttons .btn").index(e.target) % num_pages
      console.log(pageId)
      $(".pages").attr("class", "pages show-page-#{pageId}")
