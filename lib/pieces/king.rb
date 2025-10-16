require_relative 'piece'

class LightKing < Piece
  def initialize(position)
    super('light', position, '♔')
  end

  def valid_moves(board)
    # to implement later
  end
end

class DarkKing < Piece
  def initialize(position)
    super('black', position, '♚')
  end

  def valid_moves(board)
    # to implement later
  end
end