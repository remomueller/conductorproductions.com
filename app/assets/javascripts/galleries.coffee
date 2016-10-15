@galleriesReady = ->
  $('[data-object~="galleries-sortable"]').sortable(
    tolerance: 'pointer'
    handle: '.handle'
    axis: 'y'
    stop: ->
      params = {}
      params.gallery_ids = $('[data-object~="galleries-sortable"]').sortable('toArray', attribute: 'data-gallery-id')
      $.post("#{root_url}projects/#{$(this).data('project')}/categories/#{$(this).data('category')}/save_gallery_order", params, null, 'script')
      true
  )

@galleryPhotosReady = ->
  $.each($('[data-object~="gallery-photos-sortable"]'), (index, element) ->
    $this = $(this)
    $this.sortable(
      tolerance: 'pointer'
      axis: 'x'
      stop: ->
        params = {}
        params.gallery_photo_ids = $this.sortable('toArray', attribute: 'data-gallery-photo-id')
        console.log params
        $.post("#{root_url}projects/#{$(this).data('project')}/galleries/#{$(this).data('gallery')}/save_photo_order", params, null, 'script')
        true
    )
  )
