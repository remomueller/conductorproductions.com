@slidesReady = ->
  # Add smooth scrolling to all links in navbar + footer link
  $(window).on('scroll', ->
    $('.slideanim').each ->
      pos = $(this).offset().top
      winTop = $(window).scrollTop()
      if pos < winTop + 500
        $(this).addClass 'slide'
  )
