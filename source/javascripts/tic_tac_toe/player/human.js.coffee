@module 'TicTacToe.Player', ->
  class @Human extends @Base
    constructor: (options) ->
      @symbol  = options.symbol
      @view    = options.view
      @game    = options.game

      @view.tiles.forEach (row, row_index) =>
        row.forEach (td, column_index) =>
          td.on 'click', =>
            @game.play @symbol, row_index, column_index
