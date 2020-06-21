require_relative "tile.rb"
require "colorize"

class Board
  def self.from_file(file_path)
    file = File.read(file_path).split.map { |line| line.split("") }
    grd = Array.new(9) { Array.new(9) }

    file.each_with_index do |row, y|
      row.each_with_index do |val, x|
        tile = val == "0" ? Tile.new(val.to_i, true) : Tile.new(val.to_i, false)
        grd[y][x] = tile
      end
    end

    grd
  end

  attr_reader :grid

  NUM = (1..9).to_a

  def initialize(file_path)
    @grid = self.class.from_file(file_path)
  end

  def [](pos)
    y, x = pos
    grid[y][x]
  end

  def []=(pos, value)
    y, x = pos
    grid[y][x].value = value
  end

  def render
    line = "-------------------------------------"

    grid.each_with_index do |row, y|
      puts y % 3 == 0 ? red_bold(line) : line

      row.each_with_index do |tile, x|
        print x % 3 == 0 ? red_bold("|") : "|"
        print " #{tile.to_s} "
      end

      puts red_bold("|")
    end
    puts line.colorize(:red).bold
  end

  def solved?
    solved_rows? && solved_cols? && solved_squares?
  end

  def solved_rows?
    grid.all? do |row|
      NUM.all? { |n| row.one? { |tile| tile.value == n } }
    end
  end

  def solved_cols?
    grid.transpose.all? do |col|
      NUM.all? { |n| col.one? { |tile| tile.value == n } }
    end
  end

  def solved_squares?
    start_positions = [
      [0,0], [0,3], [0,6],
      [3,0], [3,3], [3,6],
      [6,0], [6,3], [6,6],
    ]

    start_positions.all? do |pos|
      NUM.all? { |n| square(pos).include?(n) }
    end
  end

  def square(start_pos)
    y, x = start_pos
    sq = []

    3.times do |i|
      3.times do |n|
        sq << grid[y + i][x + n].value
      end
    end

    sq
  end

  def red_bold(string)
    string.colorize(:red).bold
  end
end