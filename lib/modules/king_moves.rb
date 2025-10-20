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

  private

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