require_relative "board.rb"
require_relative "human_player.rb"

class Game
  def initialize(size, *player_marks)
    @players = player_marks.map { |mark| HumanPlayer.new(mark) }
    @board = Board.new(size)
    @current_player = @players[0]
  end

  def switch_turn
    @players.rotate!
    @current_player = @players[0]
  end

  def play
    while @board.empty_positions?
      @board.print_board
      pos = @current_player.get_position

      until @board.valid?(pos) && @board.empty?(pos)
        puts "Invalid position. Please select your position again."
        pos = @current_player.get_position
      end

      @board.place_mark(pos, @current_player.mark)

      if @board.win?(@current_player.mark)
        @board.print_board
        puts "#{@current_player.mark} wins the match!"
        return
      else
        switch_turn
      end
    end

    @board.print_board
    puts "There is no more space! It's a draw!"
  end
end