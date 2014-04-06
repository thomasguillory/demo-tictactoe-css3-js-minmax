@module 'TicTacToe', ->
  class @View
    constructor: (options) ->
      @el   = options.el
      @game = options.game

      # Split @el in @tiles element
      @tiles = []
      @el.find('tr').each (row_index, tr) =>
        row = []
        @tiles.push row
        $(tr).find('td').each (column_index, td) =>
          row.push $(td)


      @render()

    render: ->
      @game.board.forEach (row, row_index) =>
        row.forEach (tile, column_index) =>
          td = @tiles[row_index][column_index]

          classes = "tile tile-#{tile}"

          if tile_mark = td.children()[0]
            tile_mark = $(tile_mark)
            if tile?
              tile_mark.removeClass().addClass classes
              tile_mark.html tile
            else
              tile_mark.remove()
          else
            if tile?
              tile_mark = $('<div>').addClass(classes)
              tile_mark.html tile
              td.append tile_mark

