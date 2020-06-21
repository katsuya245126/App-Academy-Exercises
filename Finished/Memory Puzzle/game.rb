require_relative "board.rb"
require_relative "card.rb"
require_relative "human_player.rb"
require_relative "computer_player.rb"

class Game
  def initialize(player)
    @board = Board.new
    @previous_guess = nil
    @player = HumanPlayer.new("john")
  end

  def play
    reset
    @board.populate

    until @board.won?
      refresh
      
      pos = @player.prompt(@board.open_positions)
      y, x = pos
      @player.receive_revealed_card(pos, @board[y, x].value)

      if @previous_guess != nil
        prev_y, prev_x = @previous_guess
        if @board[y, x] == @board[prev_y, prev_x]
          @player.receive_match([y, x], [prev_y, prev_x])
        end
      end

      make_guess(pos)
    end

    win
  end

  private

  def make_guess(pos)
    return nil unless valid_guess?(pos)
    y, x = pos
    
    if @previous_guess == nil
      first_guess(y, x)
    else
      second_guess(y, x)
    end
  end

  def refresh
    system("clear")
    @board.render
  end

  def valid_guess?(pos)
    y, x = pos
    @board[y, x].hidden
  end

  def first_guess(y, x)
    @previous_guess = [y, x]
    @board[y, x].reveal
  end

  def second_guess(y, x)
    prev_y, prev_x = @previous_guess

    if @board[y, x] == @board[prev_y, prev_x]
      @board[y, x].reveal
    else
      @board[y, x].reveal
      refresh
      sleep(2)
      @board[prev_y, prev_x].hide
      @board[y, x].hide
    end

    @previous_guess = nil
  end

  def win
    refresh
    puts "You won!"
  end

  def reset
    @previous_guess = nil
  end
end