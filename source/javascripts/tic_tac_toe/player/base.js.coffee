@module 'TicTacToe.Player', ->
  class @Base
    constructor: (options) ->
      @symbol  = options.symbol
      @game    = options.game
