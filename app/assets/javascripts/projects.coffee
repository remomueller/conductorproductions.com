# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document)
  .on('click', "[data-object~='click-to-view']", () ->
    $(this).html($(this).data('content'))
  )
  .on('click', "[data-object~='toggle-target']", () ->
    $($(this).data('target')).toggle()
  )
