@module 'TicTacToe.Player.AImod', ->
  class @minmaxNode
    @MIN      = -999
    @MAX      = 999
    @MAXDEPTH = 9
    constructor: (board, @player, @minOrMax = 'max', @currentDepth = 0) ->
      @board      = @_copyBoard board

    value: =>
      if winner = @_isBoardWon()
        if winner == 'O'
          # console.log "Found #{@constructor.MAX} (victory) @depth #{this.currentDepth}"
        else
          # console.log "Defeat"
          # console.log @board
          # console.log "Found #{@constructor.MIN} (defeat) @depth #{this.currentDepth}"
        return {
          value:    if winner == 'O' then @constructor.MAX else @constructor.MIN
          row:      null
          column:   null
          children: []
        }

      if @_isBoardFull()
        return {
          value:    0
          row:      null
          column:   null
          children: []
        }

      if @currentDepth < @constructor.MAXDEPTH

        min = @constructor.MAX + 1
        max = @constructor.MIN - 1
        min_row  = null
        min_col  = null
        max_row  = null
        max_col  = null

        # Generate children
        children = []
        # console.log "Looking for #{this.minOrMax} @depth #{this.currentDepth}"
        @board.forEach (row, row_index) =>
          row.forEach (tile, column_index) =>
            if tile == null
              childBoard = @_copyBoard @board
              childBoard[row_index][column_index] = @player
              player    = if @player    == 'O'   then 'X' else 'O'
              minOrMax  = if @minOrMax  == 'min' then 'max' else 'min'

              node = new @constructor childBoard, player, minOrMax, @currentDepth + 1
              result = node.value()
              children.push result
              if result.value < min or result.value > max
                if result.value < min
                  min      = result.value
                  min_row  = row_index
                  min_col  = column_index
                if result.value > max
                  max      = result.value
                  max_row  = row_index
                  max_col  = column_index


        if @minOrMax == 'min'
          # console.log "Found #{min} @depth #{this.currentDepth}"
          return {
            value:    min
            row:      min_row
            column:   min_col
            children: children
          }
        else
          # console.log "Found #{max} @depth #{this.currentDepth}"
          return {
            value:    max
            row:      max_row
            column:   max_col
            children: children
          }

      else
        return {
          value:  @eval()
          row:    null
          column: null
        }

    eval: =>
      Math.random()

    _evalPattern: (pattern) =>


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

      return false
