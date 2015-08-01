@ready = () ->
  homeReady()
  videosReady()
  Turbolinks.enableProgressBar()
  fileDragReady()

$(document).ready(ready)
$(document)
  .on('page:load', ready)
  .on('click', '[data-object~="suppress-click"]', () ->
    false
  )
