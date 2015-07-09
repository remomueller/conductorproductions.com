

$(document)
  .on('click', "[data-object~='click-to-view']", () ->
    $(this).html($(this).data('content'))
  )
  .on('click', "[data-object~='toggle-target']", () ->
    $($(this).data('target')).toggle()
  )
