

class Piece 
  attr_reader :color, :position, :symbol

  def initialize(color, position, symbol)
    @color = color
    @position = position
    @symbol = symbol
  end

  def valid_moves(board)
    []
  end

  def enemy?(piece)
    piece.color != @color
  end
end