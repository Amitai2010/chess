require_relative 'knight_moves'
require_relative 'rook_moves'
require_relative 'bishop_moves'
require_relative 'pawn_moves'
require_relative '../pieces/queen'

module KingMoves
  def valid_moves(board)
    candidates = find_candidates(board)

    attacked_squares = []
    board.game_board.each do |row|
      row.each do |piece|
        next if piece == ' '
        next unless enemy?(piece)

        attacked_squares.concat(piece.attack_squares(board))
      end
    end

    attacked_squares = attacked_squares.uniq

    candidates.reject { |square| attacked_squares.include?(square) }
  end

  def attack_squares(board)
    squares = []
    x_values = [-1, -1, -1, 0, 1, 1, 1, 0]
    y_values = [1, 0, -1, -1, -1, 0, 1, 1]

    x_values.each_with_index do |x_value, i|
      row = @position[0] + y_values[i]
      col = @position[1] + x_value
      next unless row.between?(0, 7) && col.between?(0, 7)
      squares.push([row, col])
    end

    squares
  end

  def move(cords, board)
    return unless valid_moves(board).include?(cords)

    old_row, old_col = @position
    board.game_board[old_row][old_col] = ' '

    new_piece =
      case self
      when LightKing then LightKing.new(cords)
      when DarkKing  then DarkKing.new(cords)
      else self.class.new(@color, cords, @symbol)
      end

    board.game_board[cords[0]][cords[1]] = new_piece
    @position = cords
  end

  def can_castle?(board, side)
    row = (@color == 'light' ? 7 : 0)
    king_col = 4
    rook_col = side == 'left' ? 0 : 7
    start_col = side == 'left' ? 1 : 5
    end_col = side == 'left' ? 4 : 7


    king = board.game_board[row][king_col]
    rook = board.game_board[row][rook_col]

    return false if king == ' ' || rook == ' '
    return false if king.moved || rook.moved

    return false if castling_space(board, start_col, end_col, row)
    return false if check?(board)

    true
  end

  def check?(board)
    king_type = @color == 'light' ? LightKing : DarkKing

    board.game_board.each do |row|
      row.each do |square|
        next unless square.is_a?(king_type)

        if attacked_squares_for(board, @color).include?(square.position)
          return true
        end
      end
    end
    false
  end


  def castle(board, side)
    return false, 'unable to castle to the supplied side' unless can_castle?(board, side)

    king_col = side == 'left' ? 2 : 6
    rook_col = side == 'left' ? 3 : 5
    king_init_col = 4
    rook_init_col = side == 'left' ? 0 : 7
    king_type = @color == 'light' ? LightKing : DarkKing
    rook_type = @color == 'light' ? LightRook : DarkRook
    row = (@color == 'light' ? 7 : 0)

    board.game_board[row][king_col] = king_type.new([row][king_col])
    board.game_board[row][rook_col] = rook_type.new([row][rook_col])

    board.game_board[row][king_init_col] = ' '
    board.game_board[row][rook_init_col] = ' '

    @moved = true
    true
  end

  private


  def attacked_squares_for(board, color)
    attacked = []

    board.game_board.each do |row|
      row.each do |piece|
        next if piece == ' '
        next if piece.color == color

        attacked.concat(piece.attack_squares(board))
      end
    end

    attacked.uniq
  end

  def castling_space(board, starting_col, ending_col, row)
    (starting_col...ending_col).each do |col|
      return false unless board.game_board[row][col] == ' '
      return false unless attacked_squares_for(board, @color).include?([row, col])
    end
    true
  end

  def find_candidates(board)
    squares = []
    x_values = [-1, -1, -1, 0, 1, 1, 1, 0]
    y_values = [1, 0, -1, -1, -1, 0, 1, 1]

    x_values.each_with_index do |x_value, i|
      row = @position[0] + y_values[i]
      col = @position[1] + x_value
      next unless row.between?(0, 7) && col.between?(0, 7)

      target = board.game_board[row][col]
      squares.push([row, col]) if target == ' ' || enemy?(target)
    end

    squares
  end
end