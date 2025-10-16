require_relative 'piece'

class LightPawn < Piece
  def initialize(position)
    super('light', position, '♙')
  end

  def valid_moves(board)
    valid = []
    if position[0] < 6 && position[0] > 0
      valid.push([position[0] + 1, position[1]]) if board[position[0] + 1][position[1]] == ' '
    end
  end
end

class DarkPawn < Piece
  def initialize(position)
    super('black', position, '♟')
  end

  def valid_moves(board)
    # to implement later
  end
end