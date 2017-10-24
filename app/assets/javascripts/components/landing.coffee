$(window).on("scroll", ->
  winTop = $(window).scrollTop()
  windowHeight = Math.max(document.documentElement.clientHeight, window.innerHeight || 0)

  $(".navbar-conductor-invisible").each ->
    pos = $(this).offset().top
    if pos == winTop
      $(this).addClass("navbar-conductor-visible")
    else
      $(this).removeClass("navbar-conductor-visible")

  $(".navbar-conductor-invisible-offset").each ->
    if windowHeight <= winTop
      $(this).addClass("navbar-conductor-visible")
    else
      $(this).removeClass("navbar-conductor-visible")

  $(".scroll-down-arrow-visible").each ->
    pos = $(this).offset().top
    if pos - (windowHeight * 1 / 3) <= winTop
      $(this).removeClass("scroll-down-arrow-invisible")
    else
      $(this).addClass("scroll-down-arrow-invisible")
)

$(document)
  .on('click', "[data-object~='close-landing-menu']", ->
    $("#landing-menu").remove()
    false
  )

