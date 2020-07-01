# Notes
# duplicating the cards is duplicating the reference I think

require_relative "game.rb"
require_relative "card.rb"

class Board
  def initialize
    @grid = Array.new(4) { Array.new(4) }
  end

  def populate
    values = ("A".."Z").to_a
    cards = make_cards(values, (@grid.length * 2)).flat_map { |i| [i, i.dup] }.shuffle

    @grid.each_with_index do |row, y|
      row.each_with_index do |col, x|
        @grid[y][x] = cards.shift
      end
    end
  end

  def render
    puts ""
    puts "    0   1   2   3  "
    puts "  -----------------"
    puts "0 | #{@grid[0][0].display} | #{@grid[0][1].display} | #{@grid[0][2].display} | #{@grid[0][3].display} |"
    puts "  -----------------"
    puts "1 | #{@grid[1][0].display} | #{@grid[1][1].display} | #{@grid[1][2].display} | #{@grid[1][3].display} |"
    puts "  -----------------"
    puts "2 | #{@grid[2][0].display} | #{@grid[2][1].display} | #{@grid[2][2].display} | #{@grid[2][3].display} |"
    puts "  -----------------"
    puts "3 | #{@grid[3][0].display} | #{@grid[3][1].display} | #{@grid[3][2].display} | #{@grid[3][3].display} |"
    puts "  -----------------"
    puts ""
  end

  def won?
    @grid.all? do |row|
      row.all? { |card| !card.hidden }
    end
  end

  def reveal(guessed_pos)
    y, x = guessed_pos
    @grid[y][x].reveal    
  end

  def [](y, x)
    @grid[y][x]
  end

  def []=(y, x, value)
    @grid[y][x] = value
  end

  def open_positions
    positions = []

    @grid.each_with_index do |row, y|
      row.each_with_index do |card, x|
        positions << [y, x] if card.hidden
      end
    end

    positions
  end

  private 

  def make_cards(values, amount)
    choose_from = values.dup
    cards = []

    until cards.length == amount
      value = values.delete(values.sample)
      cards << Card.new(value)
    end

    cards
  end
end

