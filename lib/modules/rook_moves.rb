module RookMoves
  def valid_moves(board)
    valid = []
    sides = %w[left right down up]
    sides.each do |side|
      valid.concat(valid_moves_row(board, side))
    end
    valid
  end

  private

  def valid_moves_row(board, side)
    valid = []
    i = 0

    loop do
      i += case side
           when 'left' then -1
           when 'right'then 1
           when 'up'   then -1
           when 'down' then 1
           end

      row = @position[0] + (%w[up down].include?(side) ? i : 0)
      col = @position[1] + (%w[right left].include?(side) ? i : 0)

      break unless row.between?(0, 7) && col.between?(0, 7)

      next_square = board.game_board[row][col]

      if next_square == ' '
        valid.push([row, col])
      elsif enemy?(next_square)
        valid.push([row, col])
        break
      else
        break
      end
    end

    valid
  end
end