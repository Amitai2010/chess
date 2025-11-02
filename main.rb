require_relative 'lib/board'
require_relative 'lib/game'

board = Board.new
game = Game.new

board.print_board

#puts game.find_cords('Nd5')
#puts game.stalmate?(board)
puts game.Insufficient_Material?(board)