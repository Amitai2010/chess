require_relative 'pieces/bishop'
require_relative 'pieces/king'
require_relative 'pieces/knight'
require_relative 'pieces/pawn'
require_relative 'pieces/rook'
require_relative 'pieces/queen'

class Board
  attr_accessor :game_board

  def initialize
    @game_board = [
      [LightKing.new([0, 0]), ' ', ' ', ' ', ' ', ' ', ' ', ' '],
      [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
      [DarkKing.new([2, 0]), ' ', ' ', ' ', ' ', ' ', ' ', ' '],
      [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
      [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
      [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
      [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
      [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
    ]
  end

  def print_board
    light = "\e[48;5;223m"  # beige square
    dark  = "\e[48;5;94m"   # brown square
    reset = "\e[0m"
    row_number = 8
    @game_board.each_with_index do |row, i|
      print "#{row_number} "
      row_number -= 1
      row.each_with_index do |slot, j|
        bg = (i + j).even? ? light : dark
        print "#{bg} #{slot.symbol} #{reset}" if slot != ' '
        print "#{bg} #{slot} #{reset}" if slot == ' '
      end
      puts
    end
    puts '   a  b  c  d  e  f  g  h'
  end
  
end
