require_relative 'pieces/bishop'
require_relative 'pieces/king'
require_relative 'pieces/knight'
require_relative 'pieces/pawn'
require_relative 'pieces/rook'
require_relative 'pieces/queen'
require_relative 'board'
require 'yaml'

class Game
  def initialize
    @board = Board.new
    @current_color = 'light'
    @turn_count = 1
  end

  def play
    puts 'Welcome to chess!'
    @board.print_board

    loop do
      puts "#{@current_color.capitalize} to move:"
      king = find_king(@board, @current_color)

      if king.check?(@board)
        if checkmate?(@board, @current_color)
          puts "Checkmate! #{@current_color == 'light' ? 'Black' : 'White'} wins!"
          break
        else
          puts "You are in check!"
        end
      elsif drew?(@board)
        puts "it`s a drew!"
        break
      end

      move = gets.chomp
      if move == 'o-o'
        if king.can_castle?(@board, 'right')
          king.castle(@board, 'right')
          @current_color = 'black'
          next
        else
          puts 'cant castle'
          next
        end
      elsif move == 'o-o-o'
        if king.can_castle?(@board, 'left')
          king.castle(@board, 'left')
          @current_color = 'black'
          next
        else
          puts 'cant castle'
          next
        end
      elsif move == 'save'
        save_game
      end

      piece_class = find_piece(move)
      cords = find_cords(move)
      pieces = return_pieces(@board, piece_class, cords)

      if pieces.empty?
        puts "No valid pieces can move there. Try again."
        next
      end

      piece = if pieces.length > 1
                disambiguate(move, pieces)
              else
                pieces.first
              end

      if piece.nil?
        puts "Could not resolve which piece you meant."
        next
      end

      if move_in_check?(@board, piece.position, cords)
        puts "Illegal move – you can’t leave your king in check!"
        next
      end

      piece.move(cords, @board)
      @board.print_board

      # Switch turns
      @current_color = @current_color == 'light' ? 'black' : 'light'
      @turn_count += 1
    end
  end

  def self.load_game
    if File.exist?('saves/chess_save.yaml')
      YAML.load_file('saves/chess_save.yaml', permitted_classes: ObjectSpace.each_object(Class).to_a)
    else
      puts 'no saved game exists'
    end
  end

  private

  def save_game
    Dir.mkdir('saves') unless Dir.exist?('saves')
    File.open('saves/chess_save.yaml', 'w') do |file|
      file.puts YAML.dump(self)
    end
    puts 'game saved succesfully'
  end


  def checkmate?(board, color)
    king = find_king(board, color)
    return false unless king.check?(board)

    color_bishop = color == 'light' ? LightBishop : DarkBishop
    color_rook   = color == 'light' ? LightRook   : DarkRook

    board.game_board.each do |row|
      row.each do |square|
        next if square == ' ' || square.color != color

        valid_moves =
          if square.is_a?(color_bishop)
            square.valid_moves_bishop(board)
          elsif square.is_a?(color_rook)
            square.valid_moves_rook(board)
          else
            square.valid_moves(board)
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
        next unless square.is_a?(piece)

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

  def disambiguate(algebraic_notation, pieces)
    # If the move includes a file or rank to distinguish (like Nb2xa3)
    if algebraic_notation[1] =~ /[a-h]/
      col = algebraic_notation[1].ord - 'a'.ord
      return pieces.find { |p| p.position[1] == col }
    elsif algebraic_notation[1] =~ /[1-8]/
      row = 8 - algebraic_notation[1].to_i
      return pieces.find { |p| p.position[0] == row }
    end

    nil
  end


  def deep_copy_board(board)
    new_board = Board.new

    new_board.game_board = board.game_board.map do |row|
      row.map do |square|
        square.is_a?(String) ? ' ' : square.clone
      end
    end

    new_board
  end

  def move_in_check?(board, initial_cords, cords)
    checking_board = deep_copy_board(board)

    piece = checking_board.game_board[initial_cords[0]][initial_cords[1]]

    checking_board.game_board[cords[0]][cords[1]] = piece.class.new(cords)

    checking_board.game_board[initial_cords[0]][initial_cords[1]] = ' '

    temp_king = find_king(checking_board, @current_color)

    temp_king.check?(checking_board)
  end

  def drew?(board)
    Insufficient_Material?(board) || stalmate?(board)
  end

  def Insufficient_Material?(board)
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
    possible_moves.empty? && !king.check?(board)
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
    case algebric_notation[0]
    when 'N'
      piece_type = @current_color == 'light' ? LightKnight : DarkKnight
    when 'K'
      piece_type = @current_color == 'light' ? LightKing : DarkKing
    when 'B'
      piece_type = @current_color == 'light' ? LightBishop : DarkBishop
    when 'Q'
      piece_type = @current_color == 'light' ? LightQueen : DarkQueen
    when 'R'
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