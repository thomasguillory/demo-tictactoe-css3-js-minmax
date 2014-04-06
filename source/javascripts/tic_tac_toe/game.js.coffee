@module 'TicTacToe', ->
  class @Game
    @PLAYERS: ['X','O']

    constructor: ->
      @board = [
        [null,null,null],
        [null,null,null],
        [null,null,null]
      ]

      @nextPlayer = @constructor.PLAYERS[0]

    play: (player, row, column) =>
      unless player != @nextPlayer
        unless @board[row][column] != null
          @board[row][column] = player
          $('body').trigger('renderGame')
          @toNextPlayer()

    toNextPlayer: =>
      idx = @constructor.PLAYERS.indexOf(@nextPlayer) + 1
      idx = 0 if idx >= @constructor.PLAYERS.length
      @nextPlayer = @constructor.PLAYERS[idx]
