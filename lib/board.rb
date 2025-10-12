class Board
  attr_accessor :game_board

  def initialize
    @game_board = [  
  ["♖", "♘", "♗", "♕", "♔", "♗", "♘", "♖"],
  ["♙", "♙", "♙", "♙", "♙", "♙", "♙", "♙"],
  [" ", " ", " ", " ", " ", " ", " ", " "],
  [" ", " ", " ", " ", " ", " ", " ", " "],
  [" ", " ", " ", " ", " ", " ", " ", " "],
  [" ", " ", " ", " ", " ", " ", " ", " "],
  ["♟", "♟", "♟", "♟", "♟", "♟", "♟", "♟"],
  ["♜", "♞", "♝", "♛", "♚", "♝", "♞", "♜"]]
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
        print "#{bg} #{slot} #{reset}"
      end
      puts
    end
    puts '   a  b  c  d  e  f  g  h'
  end
  
end
