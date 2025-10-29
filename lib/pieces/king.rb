require_relative 'piece'
require_relative 'knight'
require_relative 'rook'
require_relative 'bishop'
require_relative 'pawn'
require_relative 'queen'
require_relative '../modules/king_moves'

class LightKing < Piece
  attr_reader :color, :position, :symbol, :moved

  include KingMoves
  def initialize(position)
    super('light', position, '♔')
    @moved = false
  end
end

class DarkKing < Piece
  attr_reader :color, :position, :symbol, :moved

  include KingMoves
  def initialize(position)
    super('black', position, '♚')
    @moved = false
  end
end