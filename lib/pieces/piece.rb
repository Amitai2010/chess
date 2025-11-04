

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

  def clone
    self.class.new(@position.dup).tap do |new_piece|
      new_piece.instance_variable_set(:@has_moved, @has_moved) if instance_variable_defined?(:@has_moved)
    end
  end


  def move(cords, board)
    return unless valid_moves(board).include?(cords)

    old_row, old_col = @position

    board.game_board[old_row][old_col] = ' '

    board.game_board[cords[0]][cords[1]] = self.class.new(cords)
    @position = cords
  end

  def enemy?(piece)
    return false if piece.nil? || piece == ' '

    piece.color != @color
  end
end