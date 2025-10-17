require_relative 'piece'
require_relative 'bishop'
require_relative 'knight'
require_relative 'rook'
require_relative 'queen'
require_relative '../modules/pawn_moves'

class LightPawn < Piece
  include PawnMoves
  def initialize(position)
    super('light', position, '♙')
  end

end

class DarkPawn < Piece
  include PawnMoves
  def initialize(position)
    super('black', position, '♟')
  end


end