require_relative 'lib/board'
require_relative 'lib/game'

board = Board.new
game = Game.new


#puts game.find_cords('Nd5')
#puts game.stalmate?(board)

if File.exist?('saves/chess_save.yaml')
  puts 'Would you like to load your previous game? (yes/no)'
  answer = gets.chomp.downcase

  if answer == 'yes'
    loaded_game = Game.load_game
    if loaded_game
      puts 'Loaded previous game!'
      loaded_game.play
      exit # so it doesn’t start a new one afterwards
    else
      puts 'No valid save file found. Starting a new game...'
    end
  end
end

game.play
