module PawnMoves
  def valid_moves(board)
    direction = @color == 'light' ? -1 : 1
    starting_row = @color == 'light' ? 6 : 1
    valid = []

    if @position[0] < starting_row && @position[0].positive?
      valid.push([@position[0] + direction, @position[1]]) if board.game_board[@position[0] + direction][@position[1]] == ' '
      if board.game_board[@position[0] + direction][@position[1] - 1] != ' ' && !(@position[1] - 1).nil?
        valid.push([@position[0] + direction, @position[1] - 1])
      end
      if board.game_board[@position[0] + direction][@position[1] + 1] != ' ' && !(@position[1] + 1).nil?
        valid.push([@position[0] + direction, @position[1] + 1])
      end
    elsif @position[0] == starting_row
      valid.push([@position[0] + 2 * direction, @position[1]]) if board.game_board[@position[0] + 2 * direction][@position[1]] == ' ' && board.game_board[@position[0] + direction][@position[1]] == ' '
      valid.push([@position[0] + direction, @position[1]]) if board.game_board[@position[0] + direction][@position[1]] == ' '
      if board.game_board[@position[0] + direction][@position[1] - 1] != ' ' && !(@position[1] - 1).nil? && enemy?(board.game_board[@position[0] + direction][@position[1] - 1])
        valid.push([@position[0] + direction, @position[1] - 1])
      end
      if board.game_board[@position[0] + direction][@position[1] + 1] != ' ' && !(@position[1] + 1).nil? && enemy?(board.game_board[@position[0] + direction][@position[1] + 1])
        valid.push([@position[0] + direction, @position[1] + 1])
      end
    end

    valid
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