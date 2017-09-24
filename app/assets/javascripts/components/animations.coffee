@startAnimations = ->
  $(".start-animation").removeClass("start-animation")

@animationsReady = ->
  setTimeout (->
    startAnimations()
  ), 100
