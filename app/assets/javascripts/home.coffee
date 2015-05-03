@loadActiveVideo = () ->
  iframe_container = $(".item.active[data-object~='carousel-video']")
  iframe = $("#home-iframe iframe")
  iframe.attr('src', $(iframe_container).data('video-src'))

@listener = (e) ->
  return false if !(/^https?:\/\/player.vimeo.com/).test(event.origin)
  data = JSON.parse(event.data)
  if data.event == 'ready'
    $("#home-iframe iframe")[0].contentWindow.postMessage({ "method": "addEventListener", "value": "finish" }, '*')
  else if data.event == 'finish'
    $("#carousel-videos").carousel('next')
  else
    # console.log data

@addListener = () ->
  if (window.addEventListener)
    addEventListener("message", listener, false)
  else
    attachEvent("onmessage", listener)

@homeReady = () ->
  $("#carousel-videos").carousel(interval: false)
  addListener()
  loadActiveVideo()

$(document)
  .on('slid.bs.carousel', $('#carousel-videos'), (event) ->
    loadActiveVideo()
  )
