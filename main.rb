require_relative 'lib/board'

board = Board.new

board.print_board

#print(board.game_board[4][1].valid_moves(board))
print(board.game_board[7][4].can_castle?(board, 'right'))
