@module 'TicTacToe', ->
  class @Game
    @PLAYERS: ['X','O']

    constructor: ->

      @board = [
        [null,null,null],
        ['X',null,null],
        [null,'O',null]
      ]

      @nextPlayer = @constructor.PLAYERS[0]
