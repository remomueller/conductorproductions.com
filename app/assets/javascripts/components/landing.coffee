$(window).on("scroll", ->
  $(".navbar-conductor-invisible").each ->
    pos = $(this).offset().top
    winTop = $(window).scrollTop()
    if pos == winTop
      $(this).addClass("navbar-conductor-visible")
    else
      $(this).removeClass("navbar-conductor-visible")
)

$(document)
  .on('click', "[data-object~='close-landing-menu']", ->
    $("#landing-menu").remove()
    false
  )

