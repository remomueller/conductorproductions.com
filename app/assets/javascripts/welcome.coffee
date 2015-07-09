# # Set season is used on the news page

# @setSeason = () ->
#   d = new Date()
#   season = switch (d.getMonth + 1)
#     when 12,1,2
#       'winter'
#     when 3,4,5
#       'spring'
#     when 6,7,8
#       'summer'
#     else
#       'fall'
#   $("#season-container").html(season)
