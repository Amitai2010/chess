require_relative 'piece'
require_relative '../modules/knight_moves'


class LightKnight < Piece
  include KnightMoves
  def initialize(position)
    super('light', position, '♘')
  end
end

class DarkKnight < Piece
  include KnightMoves
  def initialize(position)
    super('black', position, '♞')
  end
end