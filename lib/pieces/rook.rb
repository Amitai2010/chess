require_relative 'piece'
require_relative '../modules/rook_moves'

class LightRook < Piece
  include RookMoves
  def initialize(position)
    super('light', position, '♖')
  end
end

class DarkRook < Piece
  include RookMoves
  def initialize(position)
    super('black', position, '♜')
  end
end