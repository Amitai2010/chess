require_relative 'pieces/bishop'
require_relative 'pieces/king'
require_relative 'pieces/knight'
require_relative 'pieces/pawn'
require_relative 'pieces/rook'
require_relative 'pieces/queen'
require_relative 'board'

class Game
  def initialize
    @board = Board.new
    @current_color = 'light'
    @turn_count = 1
  end

  def play
    loop do
      
    end
  end

  def find_cords(algebric_notation)
    case algebric_notation[-2].downcase
    when 'a' then col = 0
    when 'b' then col = 1
    when 'c' then col = 2
    when 'd' then col = 3
    when 'e' then col = 4
    when 'f' then col = 5
    when 'g' then col = 6
    when 'h' then col = 7
    else
      raise "Invalid file in notation: #{algebric_notation}"
    end

    case algebric_notation[-1]
    when '1' then row = 7
    when '2' then row = 6
    when '3' then row = 5
    when '4' then row = 4
    when '5' then row = 3
    when '6' then row = 2
    when '7' then row = 1
    when '8' then row = 0
    else
      raise "Invalid rank in notation: #{algebric_notation}"
    end

    [row, col]
  end

  private

  def find_king(board, color)
    king_type = color == 'light' ? LightKing : DarkKing

    board.game_board.each do |row|
      row.each do |square|
        return square.position if square.is_a?(king_type)
      end
    end
  end

  def find_piece(algebric_notation)
    case algebric_notation[0].downcase
    when 'n'
      piece_type = @current_color == 'light' ? LightKnight : DarkKnight
    when 'k'
      piece_type = @current_color == 'light' ? LightKing : DarkKing
    when 'b'
      piece_type = @current_color == 'light' ? LightBishop : DarkBishop
    when 'q'
      piece_type = @current_color == 'light' ? LightQueen : DarkQueen
    when 'r'
      piece_type = @current_color == 'light' ? LightRook : DarkRook
    else
      piece_type = @current_color == 'light' ? LightPawn : DarkPawn
    end

    piece_type
  end


end