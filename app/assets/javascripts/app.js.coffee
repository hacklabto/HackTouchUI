# some of the items in lib/js require jquery, so load this first
#= require jquery-1.7.1.min.js
# then the rest
#= require_tree ../../../lib/assets/javascripts
#= require_tree .

$ ->
  $("html").mousedown (e) ->
    e.stopPropagation()
    e.preventDefault()
    false
