require_relative 'piece'

class Pawn < Piece

  def initialize(color, position)
    @color = color
    @position = position
    @symbol = '♙'
  end

  def valid_moves(board)
    valid = []

    if @color == 'white'
      
    end
  end
end