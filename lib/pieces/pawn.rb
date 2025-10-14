require_relative 'piece'

class Pawn < Piece

  def initialize(color, position)
    @color = color
    @position = position
    @symbol = '♙'
  end

  def valid_moves(board)
    valid = []

    if @color == 'white'
      if position[0] < 6 && position[0] > 0 && board.game_board[position[0] + 1][position[1]] == ' '
        valid.push([position[0] + 1, position[1]])
      elsif position[0] == 6 && board.game_board[position[0] + 1][position[1]] == ' '
        board.game_board[position[0] + 2][position[1]] == ' ' ? valid.push([position[0] + 1, position[1]]) && valid.push([position[0] + 2, position[1]]) : valid.push([position[0] + 1, position[1]])
      end
      valid.push([position[0] - 1, position[1] - 1]) if board.game_board[position[0] + 1][position[1] - 1] != ' '
      valid.push([position[0] - 1, position[1] + 1]) if board.game_board[position[0] + 1][position[1] + 1] != ' '
    end
  end
end