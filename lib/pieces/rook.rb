require_relative 'piece'
require_relative '../modules/rook_moves'

class LightRook < Piece
  attr_accessor :color, :position, :symbol, :moved

  include RookMoves
  def initialize(position)
    super('light', position, '♖')
    @moved = false
  end
end

class DarkRook < Piece
  attr_accessor :color, :position, :symbol, :moved

  include RookMoves
  def initialize(position)
    super('black', position, '♜')
    @moved = false
  end
end