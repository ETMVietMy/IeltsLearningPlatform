# jQuery.noConflict()
$ ->
  $('#js-new-suggestion').click (e) -> 
    e.prefentDefault
    url = '/dashboard/tasks/suggest.js'
    $.getScript url
