require_relative 'lib/board'
require_relative 'lib/game'

board = Board.new
game = Game.new

board.print_board

#print(board.game_board[4][1].valid_moves(board))
print(board.game_board[7][4].can_castle?(board, 'right'))
print(board.game_board[7][4].check?(board))
print(board.game_board[7][4].move([7, 2], board))
board.print_board
puts game.find_cords('Nd5')