# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document)
  .on('click', 'body, #shade', () ->
    $("#shade").fadeOut()
    $("#other-videos").show()
    $("#video-frame").hide()
    $("#video-frame iframe").attr('src', "")
  )
  .on('click', "[data-object~='launch-video']",()->
    $("#shade").fadeIn()
    $("#video-frame").show()
    url = $(this).data('video-src') || ""
    $("#video-frame iframe").attr('src', url)
    $("#other-videos").hide()
    false
  )
  .on('click', "[data-object~='launch-video'], #video-frame",()->
    false
  )
