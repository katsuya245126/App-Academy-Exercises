require_relative "board.rb"
require_relative "human_player.rb"

class Sudoku
  attr_reader :board, :player

  def initialize(player, file_path)
    @player = player
    @board = Board.new(file_path)
  end

  def play
    until board.solved?
      system("clear")
      board.render
      pos_value = player.prompt
      y, x = pos_value[0]
      board[[y,x]] = pos_value[1]
    end

    system("clear")
    board.render
    win
  end

  private

  def win
    puts "Congratulations! You won!"
  end
end