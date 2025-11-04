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

    puts 'Welcom to chess!'
    @board.print_board
    loop do
      puts "#{@current_color} to move"
      move = gets

      piece = find_piece(move)
      cords = find_cords(move)

      if return_pieces(@board, piece, cords).length == 1
        
      end
    end
  end

  private

  def checkmate?(board, color)
    king = find_king(board, color)
    return false unless king.check?(board)

    color_bishop = color == 'light' ? LightBishop : DarkBishop
    color_rook = color == 'light' ? LightRook : DarkRook

    board.game_board.each do |row|
      row.each do |square|
        next if square == ' ' || square.color != color

        valid_moves =
          case square
          when color_bishop then square.valid_moves_bishop(board)
          when color_rook   then square.valid_moves_rook(board)
          else square.valid_moves(board)
          end

        valid_moves.each do |move|
          return false unless move_in_check?(board, square.position, move)
        end
      end
    end

    true
  end

  def return_pieces(board, piece, cords)
    pieces = []

    board.game_board.each do |row|
      row.each do |square|
        next if square == ' '
        next unless square.is_a?(piece.class)

        valid_moves =
          case square
          when LightBishop, DarkBishop then square.valid_moves_bishop(board)
          when LightRook, DarkRook     then square.valid_moves_rook(board)
          else square.valid_moves(board)
          end

        pieces << square if valid_moves.include?(cords)
      end
    end

    pieces
  end

  def same_col?(pieces)
    return true if pieces[0][1] == pieces[1][1]

    false
  end

  def currect_piece_same_col(algebric_notation)
    [find_row(algebric_notation), find_col(algebric_notation)]
  end

  def currect_piece_diff_col(algebraic_notation, pieces)
    target_col = find_col(algebraic_notation)

    matching_piece = pieces.find { |piece| piece.position[1] == target_col }

    matching_piece ? matching_piece.position : nil
  end

  def find_row(algebraic_notation)
    8 - algebraic_notation[2].to_i
  end

  def find_col(algebraic_notation)
    algebraic_notation[-2].ord - 'a'.ord
  end

  def move_in_check?(board, initial_cords, cords)
    king = find_king(board, @current_color)

    if king.check?(board)
      piece_type = board.game_board[initial_cords[0]][initial_cords[1]].class

      checking_board = board.game_board.map do |row|
        row.map { |square| square.is_a?(String) ? square : square.dup }
      end

      checking_board[cords[0]][cords[1]] = piece_type.new([cords[0], cords[1]])
      checking_board[initial_cords[0]][initial_cords[1]] = ' '

      temp_king = find_king(checking_board, @current_color)
      return true unless temp_king.check?(checking_board)

      false
    end

    false
  end

  def drew?(board)
    Insufficient_Material?(board) || stalmate?(board)
  end

  def Insufficient_Material(board)
    material = { 'light_knights' => 0, 'light_bishops' => 0, 'dark_knights' => 0, 'dark_bishops' => 0 }

    board.game_board.each do |row|
      row.each do |square|
        if square.is_a?(LightPawn) || square.is_a?(DarkPawn) || square.is_a?(LightQueen) || square.is_a?(DarkQueen) || square.is_a?(LightRook)  || square.is_a?(DarkRook)
          return false
        end

        if square.is_a?(LightBishop)
          material['light_bishops'] += 1
        elsif square.is_a?(DarkBishop)
          material['dark_bishops'] += 1
        elsif square.is_a?(LightKnight)
          material['light_knights'] += 1
        elsif square.is_a?(DarkKnight)
          material['dark_knights'] += 1
        end
      end
    end
    if (material['light_knights'] == 1 && material['light_bishops'] == 1) || material['light_bishops'] == 2
      return false
    end

    if (material['dark_knights'] == 1 && material['dark_bishops'] == 1) || material['dark_bishops'] == 2
      return false
    end

    true
  end


  def stalmate?(board)
    possible_moves = []
    color_bishop = @current_color == 'light' ? LightBishop : DarkBishop
    color_rook = @current_color == 'light' ? LightRook : DarkRook

    board.game_board.each do |row|
      row.each do |square|
        if square != ' '
          next unless square.color == @current_color

          if square.is_a?(color_bishop)
            possible_moves.concat(square.valid_moves_bishop(board))
          elsif square.is_a?(color_rook)
            possible_moves.concat(square.valid_moves_rook(board))
          else
            possible_moves.concat(square.valid_moves(board))
          end
        end
      end
    end
    king = find_king(board, @current_color)
    possible_moves.empty? && !board.game_board[king[0]][king[1]].check?(board)
  end

  def find_king(board, color)
    king_type = color == 'light' ? LightKing : DarkKing

    board.game_board.each do |row|
      row.each do |square|
        return square if square.is_a?(king_type)
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
end