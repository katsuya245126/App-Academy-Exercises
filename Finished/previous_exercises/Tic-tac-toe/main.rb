require_relative "tic_tac_toe_v3/board.rb"
require_relative "tic_tac_toe_v3/human_player.rb"
require_relative "tic_tac_toe_v3/game.rb"
require_relative "tic_tac_toe_v3/computer_player.rb"

game = Game.new(11, O: false, X: true, W: true)
board = Board.new(5)
human = HumanPlayer.new(:X)
bot = ComputerPlayer.new(:O)

p game.play
