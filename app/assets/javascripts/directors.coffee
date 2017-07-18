$(document)
  .on('click', "[data-object~='launch-director-video']", ->
    url = $(this).data('video-src') || ""
    $("#director-video-frame iframe").attr('src', url)
    false
  )
