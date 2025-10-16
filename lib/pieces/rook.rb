require_relative 'piece'

class LightRook < Piece
  def initialize(position)
    super('light', position, '♖')
  end

  def valid_moves(board)
    # to implement later
  end
end

class DarkRook < Piece
  def initialize(position)
    super('black', position, '♜')
  end

  def valid_moves(board)
    # to implement later
  end
end