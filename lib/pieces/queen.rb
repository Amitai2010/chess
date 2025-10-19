require_relative 'piece'
require_relative '../modules/bishop_moves'
require_relative '../modules/rook_moves'

class LightQueen < Piece
  include BishopMoves
  include RookMoves
  def initialize(position)
    super('light', position, '♕')
  end

  def valid_moves(board)
    valid_moves_bishop(board).concat(valid_moves_rook(board))
  end
end

class DarkQueen < Piece
  include BishopMoves
  include RookMoves
  def initialize(position)
    super('black', position, '♛')
  end

  def valid_moves(board)
    valid_moves_bishop(board).concat(valid_moves_rook(board))
  end
end