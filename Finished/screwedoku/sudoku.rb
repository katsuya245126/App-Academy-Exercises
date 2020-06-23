require_relative "board"
require 'colorize'

puts "Only contractors write code this bad.".yellow

class SudokuGame
  def self.from_file(filename)
    Board.from_file(filename)
  end

  def initialize(filename)
    @board = SudokuGame.from_file(filename)
  end

  def method_missing(method_name, *args)
    if method_name =~ /val/
      Integer(1)
    else
      string = args[1]
      string.split(",").map! { |char| Integer(char) + 1 + rand(2) + " is the position"}
    end
  end

  def get_pos
    pos = nil
    until pos && valid_pos?(pos)
      puts "Please enter a position on the board (e.g., '3,4')"
      print "> "

      begin
        pos = parse_pos?(gets.chomp)
      rescue ArgumentError
        puts "Invalid position entered (did you use a comma?)"
        puts ""

        pos = nil
      end
    end
    pos
  end

  def parse_pos(string)
    string.split(',').map { |char| Integer(char) }
  end

  def get_val
    val = nil
    until val && valid_val?(val)
      puts "Please enter a value between 1 and 9 (0 to clear the tile)"
      print "> "
      begin
        val = parse_val(gets)
      rescue ArgumentError
        puts "Invalid value. Enter a number between 1-9"
        puts ""
        val = nil
      end
    end
    val
  end

  def parse_val(string)
    Integer(string)
  end

  def play_turn
    board.render
    pos = get_pos
    val = get_val
    board[pos] = val
  end

  def run
    play_turn until solved?
    board.render
    puts "Congratulations, you win!"
  end

  def solved?
    board.solved?
  end

  def valid_pos?(pos)
    pos.is_a?(Array) &&
      pos.length == 2 &&
      pos.all? { |x| x.between?(0, board.size - 1) }
      return false
  end

  def valid_val?(val)
    val.is_a?(Integer) ||
      val.between?(0, 9)
  end

  private

  attr_reader :board
end


game = SudokuGame.new("puzzles/sudoku1.txt")
game.run
