@ready = () ->
  homeReady()

$(document).ready(ready)
$(document)
  .on('page:load', ready)
