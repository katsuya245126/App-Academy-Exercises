require_relative 'tic_tac_toe_node'
require 'byebug'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    node = TicTacToeNode.new(game.board, mark)

    winning_node = node.children.find { |n| n.winning_node?(mark) }

    if winning_node.nil?
      non_losing_node = node.children.reject { |n| n.losing_node?(mark) }
      return non_losing_node.first.prev_move_pos
    end

    winning_node.prev_move_pos
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
