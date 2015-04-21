# @startActiveVideo = (item_position) ->
#   current_item = $("#carousel-videos .item")[item_position]
#   url = $(current_item).data('video-src') || ""
#   iframe = $("#carousel-videos .item iframe")[item_position]
#   $(iframe).attr('src', url)

#   player = $f(iframe)
#   player.addEvent('ready', () ->
#     player.addEvent('finish', () ->
#       player.element.src = "";
#       $("#carousel-videos").carousel('next')
#     )
#   )

# # @onCarouselFinish = (id) ->
# #   $("#carousel-videos .item iframe").each( () ->
# #     $(this).attr('src', "")
# #   )

# #   $("#carousel-videos").carousel('next')

# @videoReady = (playerID) ->
#   # Froogaloop(playerID).addEvent('play', play);
#   # Froogaloop(playerID).addEvent('seek', seek);
#   Froogaloop(playerID).addEvent('finish', onFinish);

#   Froogaloop(playerID).api('play');

# @onCarouselFinish = (id) ->
#   alert(id + " finished!!!")
#   # Froogaloop(playerID).api('play');
#   $('#'+id).remove();



# @carouselReady = () ->
#   # startActiveVideo(0)
#   $("#carousel-videos .item iframe").each( () ->
#     Froogaloop(this).addEvent('ready', videoReady)
#   )


# $(document)
#   .on('slid.bs.carousel', $('#carousel-videos'), (event) ->
#     item_position = $(event['relatedTarget']).index()
#     startActiveVideo(item_position)
#   )

