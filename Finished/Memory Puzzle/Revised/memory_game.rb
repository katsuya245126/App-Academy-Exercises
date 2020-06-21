require_relative "computer_player.rb"
require_relative "human_player.rb"
require_relative "board.rb"

class MemoryGame
  attr_reader :player

  def initialize(player, size = 4)
    @board = Board.new(size)
    @previous_guess = nil
    @player = player
  end

  def play
    until board.won?
      system("clear")
      board.render
      pos = get_player_input
      make_guess(pos)
    end

    puts "You win!"
  end

  # compares current guess to previous guess
  def compare_guess(guess)
    # If previous guess exists, compare it to current guess
    # otherwise, set previous guess to current guess
    if previous_guess 
      if match?(previous_guess, guess)
        # if it matches, keep the cards face up and send matching positions to player
        player.receive_match(previous_guess, guess)
      else
        # if it doesn't match, display error and hide the cards 
        puts "It didn't match! Try again."
        board.hide(previous_guess)
        board.hide(guess)
      end
      # set previous guess to nil if it's second guess
      self.previous_guess = nil
      player.previous_guess = nil
    else
      self.previous_guess = guess
      player.previous_guess = guess
    end
  end

  def get_player_input
    guess = nil

    until valid_pos?(guess)
      guess = player.get_input
    end

    guess
  end

  # reveals card on board[pos] and renders board
  def make_guess(pos)
    value = board.reveal(pos)
    player.receive_revealed_card(pos, value)
    system("clear")
    board.render

    compare_guess(pos)
    
    sleep(1)
    system("clear")
    board.render
  end

  def match?(pos_1, pos_2)
    board[pos_1] == board[pos_2]
  end

  # it's a valid position if it
  # -is an array
  # -contains 2 elements
  # -the elements are numbers between 0 and board size - 1
  def valid_pos?(pos)
    pos.is_a?(Array) && pos.length == 2 && pos.all? { |n| n.between?(0, board.size - 1) }
  end

  private

  attr_accessor :previous_guess
  attr_reader :board
end

if $PROGRAM_NAME == __FILE__
  size = ARGV.empty? ? 4 : ARGV.shift.to_i
  MemoryGame.new(HumanPlayer.new(size), size).play
end