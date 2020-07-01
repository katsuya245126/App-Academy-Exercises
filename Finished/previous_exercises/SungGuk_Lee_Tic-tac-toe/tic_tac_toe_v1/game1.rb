require_relative "board.rb"
require_relative "human_player.rb"

class Game
  def initialize(player_1_mark, player_2_mark)
    @player1 = HumanPlayer.new(player_1_mark)
    @player2 = HumanPlayer.new(player_2_mark)
    @board = Board.new
    @current_player = @player1
  end

  def switch_turn
    if @current_player == @player1
      @current_player = @player2
    else
      @current_player = @player1
    end
  end

  def play
    while @board.empty_positions?
      @board.print
      pos = @current_player.get_position

      until @board.valid?(pos) && @board.empty?(pos)
        puts "Invalid position. Please select your position again."
        pos = @current_player.get_position
      end

      @board.place_mark(pos, @current_player.mark)

      if @board.win?(@current_player.mark)
        @board.print
        puts "#{@current_player.mark} wins the match!"
        return
      else
        switch_turn
      end
    end

    @board.print
    puts "There is no more space! It's a draw!"
  end
end