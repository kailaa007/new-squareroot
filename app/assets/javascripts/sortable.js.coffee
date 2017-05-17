jQuery ($) ->
  $(document).ready ->

    sortableTable = $('.sortable-table')

    if sortableTable.length
      sortableTable.sortable
        axis: 'y'
        handle: '.icon-move'
        items: 'tbody tr'
        stop: ->
          ids = {}
          $('tbody tr', sortableTable).map (i) ->
            ids[ $(this).attr('data-id') ] = i unless $(this).attr('data-id') == undefined

          $.post sortableTable.attr('data-url'), { sort: ids }, ->
            $('body').effect('highlight')