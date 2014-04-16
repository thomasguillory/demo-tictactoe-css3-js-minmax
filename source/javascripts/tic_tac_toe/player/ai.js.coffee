#= require ./ai/minmaxNode

@module 'TicTacToe.Player', ->
  class @AI extends @Base
    constructor: (options) ->
      super
      $('body').on 'nextPlayer', (evt, nextPlayer) =>
        @play() if nextPlayer == @symbol

    play: =>
      minmaxRootNode = new TicTacToe.Player.AImod.minmaxNode @game.board, @symbol
      result = minmaxRootNode.value()

      if result.row? and  result.column?
        @game.play @symbol, result.row, result.column
      else
        alert('Egality Try Again')

      if result.value == 999
        alert('Ruby Win')