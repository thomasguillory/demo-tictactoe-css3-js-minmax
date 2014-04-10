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
      console.log result
      @game.play @symbol, result.row, result.column
