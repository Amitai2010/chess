module BishopMoves
  def valid_moves_bishop(board)
    valid = []
    sides = %w[top-left top-right bottom-left bottom-right]
    sides.each do |side|
      valid.concat(valid_moves_diagonal(board, side))
    end
    valid
  end

  private

  def valid_moves_diagonal(board, side)
    valid = []
    x = 0
    y = 0

    loop do
      x += case side
           when 'top-left' then -1
           when 'top-right'then 1
           when 'bottom-left'   then -1
           when 'bottom-right' then 1
           end
      y += case side
           when 'top-left' then -1
           when 'top-right'then -1
           when 'bottom-left'   then 1
           when 'bottom-right' then 1
      end

      row = @position[0] + x
      col = @position[1] + y

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