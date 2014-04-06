@module 'TicTacToe.Player', ->
  class @AI extends @Base
    constructor: (options) ->
      super
      $('body').on 'nextPlayer', (evt, nextPlayer) =>
        @play() if nextPlayer == @symbol

    play: =>
      console.log "Should play NOW"
