@categoriesReady = ->
  $.each($('[data-object~="categories-sortable"]'), (index, element) ->
    $this = $(this)
    $this.sortable(
      tolerance: 'pointer'
      axis: 'y'
      stop: ->
        params = {}
        params.top_level = $this.data('top-level')
        params.category_ids = $this.sortable('toArray', attribute: 'data-category-id')
        $.post("#{root_url}projects/#{$this.data('project')}/save_category_order", params, null, 'script')
        true
    )
  )
