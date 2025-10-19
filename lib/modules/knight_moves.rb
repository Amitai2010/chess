module KnightMoves
  def valid_moves(board)
    valid = []
    options = []
    x_values = [-2, -2, -1, -1, 1, 1, 2, 2]
    y_values = [-1, 1, -2, 2, -2, 2, -1, 1]

    x_values.each_with_index do |dx, i|
      dy = y_values[i]
      options.push([@position[0] + dx, @position[1] + dy])
    end

    options.each do |option|
      valid.push(option) if valid_move(board, option)
    end

    valid
  end

  private

  def valid_move(board, cord)
    return false unless cord[0].between?(0, 7) && cord[1].between?(0, 7)
    if board.game_board[cord[0]][cord[1]] == ' '
      return true
    end

    if !board.game_board[cord[0]][cord[1]].nil? && enemy?(board.game_board[cord[0]][cord[1]])
      return true
    end

    false
  end

end