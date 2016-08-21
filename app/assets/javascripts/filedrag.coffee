@isNotInternetExplorer = ->
  ua = window.navigator.userAgent
  msie = ua.indexOf("MSIE ")
  if (msie > 0 || !!navigator.userAgent.match(/Trident.*rv\:11\./)) # If Internet Explorer, return version number
    # parseInt(ua.substring(msie + 5, ua.indexOf(".", msie)))
    return false
  else # If another browser
    return true

@fileDragReady = ->
  if window.FormData != undefined and isNotInternetExplorer()
    $("#filedrag").show()

$(document)
  .on('dragenter', '[data-object~="dropfile"]', (e) ->
    e.stopPropagation()
    e.preventDefault()
  )
  .on('dragover', '[data-object~="dropfile"]', (e) ->
    e.stopPropagation()
    e.preventDefault()
  )
  .on('drop', '[data-object~="dropfile"]', (e) ->
    e.stopPropagation()
    e.preventDefault()

    event = e.originalEvent || e
    data = new FormData()
    $.each(event.dataTransfer.files, (index, file) ->
      data.append 'photos[]', file
    )

    project = $(this).data('project')
    location = $(this).data('location')

    $.ajax(
      url: root_url + "projects/#{project}/locations/#{location}/upload_photos.js"
      type: 'PATCH'
      data: data         # The form with the file inputs.
      processData: false # Using FormData, no need to process data.
      contentType: false
    ).done( ->
      console.log("Success: Files sent!")
    ).fail( ->
      console.log("An error occurred, the files couldn't be sent!")
    )
  )
