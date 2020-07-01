require_relative "board"
require_relative "player"

class Battleship
  attr_reader :board, :player

  def initialize(n)
    @player = Player.new
    @board = Board.new(n)
    @remaining_misses = (n * n) / 2
  end

  def start_game
    @board.place_random_ships
    puts @board.num_ships
    @board.print
  end

  def lose?
    if @remaining_misses <= 0
      puts "you lose"
      return true
    else
      return false
    end
  end

  def win?
    ships_left = @board.num_ships

    if ships_left == 0
      puts "you win"
      return true
    else
      return false
    end
  end

  def game_over?
    if win? || lose? then return true else return false end
  end

  def turn
    player_move = @player.get_move
    attack_successful = @board.attack(player_move)
    @board.print

    unless attack_successful
      @remaining_misses -= 1
    end

    puts @remaining_misses
  end
end
