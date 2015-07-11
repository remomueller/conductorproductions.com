@ready = () ->
  homeReady()

$(document).ready(ready)
$(document)
  .on('page:load', ready)
  .on('click', '[data-object~="suppress-click"]', () ->
    false
  )
