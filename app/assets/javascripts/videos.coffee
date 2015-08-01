@videosReady = () ->
  $('[data-object~="videos-sortable"]').sortable(
    handle: ".handle"
    axis: "y"
    stop: () ->
      sortable_order = $('[data-object~="videos-sortable"]').sortable('toArray', attribute: 'data-video-id')
      params = {}
      params.video_page = $(this).data('video-page')
      params.video_ids = sortable_order
      $.post(root_url + 'videos/save_video_order', params, null, "script")
      true
  )

@onFinish = (id) ->
  $("#shade").click()

$(document)
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
