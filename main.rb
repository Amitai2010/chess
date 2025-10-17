require_relative 'lib/board'

board = Board.new

board.print_board

print(board.game_board[4][3].valid_moves(board))