

class Piece 
  attr_reader :color, :position, :symbol

  def initialize(color, position)
    @color = color
    @position = position
    @symbol = ' '
  end

  def valid_moves(board)
    []
  end

  def enemy?(piece)
    piece.color = @color ? false : true
  end
end