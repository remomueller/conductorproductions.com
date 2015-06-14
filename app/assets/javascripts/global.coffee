
@ready = () ->
  console.log 'Ready'
  globalReady()

$(document).ready(ready)
$(document)
  .on('page:load', ready)
