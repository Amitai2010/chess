require_relative 'lib/board'

board = Board.new

board.print_board

print(board.game_board[3][2].valid_moves(board))