# some of the items in lib/js require jquery, so load this first
#= require ../../lib/js/jquery-1.7.1.min.js
#= require ../../lib/js/jquery-ui-1.8.16.custom.min.js
# then the rest
#= require_tree ../../lib/js/
#= require clock
#= require streetcar
#= require weather
#= require kittenwar
#= require audio
#= require navigation
#= require news

$ ->
  $("html").mousedown (e) ->
    e.stopPropagation()
    e.preventDefault()
    false
