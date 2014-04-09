@module 'TicTacToe.Player.AImod', ->
  class @minmaxNode
    @MAXDEPTH = 9
    constructor: (board, @player, @minOrMax = 'max', @currentDepth = 0) ->
      @board      = @_copyBoard board

    value: =>
      if @_isBoardFull()
        return {
          value:  0
          row:    null
          column: null
        }

      if winner = @_isBoardWon()
        return {
          value:  (winner == @player) - (winner != @player)
          row:    null
          column: null
        }

      if @currentDepth < @constructor.MAXDEPTH

        min = 999
        max = -999
        minmax_row  = null
        minmax_col  = null

        # Generate children
        childrenNodes = []
        @board.forEach (row, row_index) =>
          row.forEach (tile, column_index) =>
            if tile == null
              childBoard = @_copyBoard @board
              childBoard[row_index][column_index] = @player
              minOrMax = if @minOrMax == 'min' then 'max' else 'min'

              node = new @constructor childBoard, @player, minOrMax, @currentDepth + 1
              result = node.value()
              if result.value < min or result.value > max
                min         = result.value if result.value < min
                max         = result.value if result.value > max
                minmax_row  = row_index
                minmax_col  = column_index


        return {
          value:  if @minOrMax == 'min' then min else max
          row:    minmax_row
          column: minmax_col
        }

      else
        return {
          value:  @eval()
          row:    null
          column: null
        }

    eval: =>
      Math.random()

    _copyBoard: (board) =>
      ret = []
      board.forEach (row) =>
        ret.push row.slice(0)
      ret

    _isBoardFull: =>
      isFull = true
      @board.forEach (row, row_index) =>
        row.forEach (tile, column_index) =>
          isFull = isFull and tile?
      isFull

    _isBoardWon: =>
      # Test rows
      for row in [0..2]
        if @board[row][0] == @board[row][1] == @board[row][2]
          return @board[row][0]

      # Test cols
      for col in [0..2]
        if @board[0][col] == @board[1][col] == @board[2][col]
          return @board[0][col]

      # Test diags
      if @board[0][0] == @board[1][1] == @board[2][2]
        return @board[0][0]
      if @board[2][0] == @board[1][1] == @board[0][2]
        return @board[2][0]
