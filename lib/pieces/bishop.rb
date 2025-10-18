require_relative 'piece'
require_relative '../modules/bishop_moves'

class LightBishop < Piece
  include BishopMoves
  def initialize(position)
    super('light', position, '♗')
  end
end

class DarkBishop < Piece
  include BishopMoves
  def initialize(position)
    super('black', position, '♝')
  end
end