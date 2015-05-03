# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

@onFinish = (id) ->
  $("#shade").click()

@setYear = () ->
  year = new Date().getFullYear()
  $("#current-year").html(year)

@globalReady = () ->
  d = new Date()
  season = switch (d.getMonth + 1)
    when 12,1,2
      'winter'
    when 3,4,5
      'spring'
    when 6,7,8
      'summer'
    else
      'fall'
  $("#season-container").html(season)
  setYear()
  homeReady()

$(document)
  .ready(globalReady)
  .on('click touchstart', '#shade', () ->
    $("#shade").fadeOut()
    $("#other-videos").show()
    $("#video-frame").hide()
    $("#video-frame iframe").attr('src', "")
    false
  )
  .on('click', "[data-object~='launch-video']",()->
    $("#shade").fadeIn()
    $("#video-frame").show()
    url = $(this).data('video-src') || ""
    $("#video-frame iframe").attr('src', url)

    iframe = $("#video-frame iframe")[0]
    player = $f(iframe)
    player.addEvent('ready', () ->
      player.addEvent('finish', onFinish)
    )

    $("#other-videos").hide()
    false
  )
  .on('click', "[data-object~='launch-video'], #video-frame",()->
    false
  )
