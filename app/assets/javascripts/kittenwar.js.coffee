$ ->
  $(".draw-btn, .kitten-images a").click ->
    $.get "http://query.yahooapis.com/v1/public/yql",
      format: "xml",
      q: 'select * from html where url="http://kittenwar.com"',
      (xml) ->
        $(xml).find("#kittentable a img").each (image_index) ->
          $(".kitten-images .image").eq(image_index).css "backgroundImage", "url(http://kittenwar.com#{$(this).attr('src')})"
          $(".kitten-names .kitten-name").eq(image_index).text($(this).attr('title'))
