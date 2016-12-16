$(document)
  .on('click', "[data-object~='launch-newsletter-video']", ->
    $("#shade").fadeIn()
    video_container_parent = "[data-object~='video-frame-container'][data-position=#{$(this).data('position')}]"
    $(video_container_parent).find('.yir-video-left').hide()
    $(video_container_parent).find('.yir-video-right').hide()
    video_container = $(video_container_parent).find('.yir-video-frame-container')
    video_container.show()

    url = $(this).data('video-src') || ''
    $(video_container).find('iframe').attr('src', url)

    iframe = $(video_container).find('iframe')[0]
    player = $f(iframe)
    player.addEvent('ready', ->
      player.addEvent('finish', onFinish)
    )
    $('html, body').animate { scrollTop: $(video_container_parent).offset().top - 5 }
    false
  )
