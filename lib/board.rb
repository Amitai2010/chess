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
      [
        DarkRook.new([0, 0]), DarkKnight.new([0, 1]), DarkBishop.new([0, 2]), DarkQueen.new([0, 3]),
        DarkKing.new([0, 4]), DarkBishop.new([0, 5]), DarkKnight.new([0, 6]), DarkRook.new([0, 7])
      ],
      [
        DarkPawn.new([1, 0]), DarkPawn.new([1, 1]), DarkPawn.new([1, 2]), DarkPawn.new([1, 3]),
        DarkPawn.new([1, 4]), DarkPawn.new([1, 5]), DarkPawn.new([1, 6]), DarkPawn.new([1, 7])
      ],
      [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
      [' ', ' ', DarkQueen.new([3, 2]), ' ', ' ', ' ', ' ', ' '],
      [' ', DarkKing.new([4, 1]), ' ', ' ', ' ', ' ', ' ', ' '],
      [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
      [
        LightPawn.new([6, 0]), LightPawn.new([6, 1]), LightPawn.new([6, 2]), LightPawn.new([6, 3]),
        LightPawn.new([6, 4]), LightPawn.new([6, 5]), LightPawn.new([6, 6]), LightPawn.new([6, 7])
      ],
      [
        LightRook.new([7, 0]), LightKnight.new([7, 1]), LightBishop.new([7, 2]), LightQueen.new([7, 3]),
        LightKing.new([7, 4]), LightBishop.new([7, 5]), LightKnight.new([7, 6]), LightRook.new([7, 7])
      ]
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
