# Navigation
$ ->
  show_page = (href) ->
    page_id = href.replace /.*page-/, ""
    $(".pages").attr("class", "pages show-page-#{page_id}")
    $(".navbar .nav li").removeClass("active")
    $(".navbar .nav li").has("a[href=\"#{href}\"]").addClass("active")

  $(".navbar .nav").on "click", "a", (e) ->
    show_page $(this).attr('href')

  show_page location.hash
