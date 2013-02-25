# Navigation
$ ->
  class Router extends Backbone.Router
    routes:
      "page-:id": "getPage"

  router = new Router
  router.on 'route:getPage', (id) ->
    $(".pages").attr("class", "pages show-page-#{id}")
    $(".navbar .active").removeClass("active")
    $(".navbar #nav-#{id}").addClass("active")

  $(".navbar .nav").on "click", "a", (e) ->
    router.navigate $(this).attr('href'), {trigger: true}

  Backbone.history.start()
