module PawnMoves
  def valid_moves(board)
    direction = @color == 'light' ? -1 : 1
    starting_row = @color == 'light' ? 6 : 1
    valid = []

    row = @position[0]
    col = @position[1]

    # Move one square forward
    new_row = row + direction
    if new_row.between?(0, 7) && board.game_board[new_row][col] == ' '
      valid << [new_row, col]

      # Move two squares forward from starting row
      two_row = row + 2 * direction
      if row == starting_row && board.game_board[two_row][col] == ' ' && board.game_board[new_row][col] == ' '
        valid << [two_row, col]
      end
    end

    # Captures
    [-1, 1].each do |dc|
      new_col = col + dc
      if new_row.between?(0, 7) && new_col.between?(0, 7)
        target = board.game_board[new_row][new_col]
        valid << [new_row, new_col] if target != ' ' && enemy?(target)
      end
    end

    valid
  end

  def attack_squares(board)
    direction = @color == 'light' ? -1 : 1
    squares = []
    squares.push([@position[0] + direction, @position[1] - 1]) if board.game_board[@position[0] + direction][@position[1] - 1] != nil
    squares.push([@position[0] + direction, @position[1] + 1]) if board.game_board[@position[0] + direction][@position[1] - 1] != nil
    squares
  end

  def pawn_conversion(conversion, board)
    if last_row?
      case conversion
      when '=q'
        board.game_board[position[0]][position[1]] = LightQueen.new([[position[0]], [position[1]]])
      when '=n'
        board.game_board[position[0]][position[1]] = LightKnight.new([[position[0]], [position[1]]])
      when '=r'
        board.game_board[position[0]][position[1]] = LightRook.new([[position[0]], [position[1]]])
      when '=b'
        board.game_board[position[0]][position[1]] = LightBishop.new([[position[0]], [position[1]]])
      end
    end
  end

  private

  def last_row?
    return true if @position[0] == 0

    false
  end
end