class Board
  attr_reader :size

  def initialize(n)
    @grid = Array.new(n) { Array.new(n, :N) }
    @size = n*n
  end

  def [](position)
    row, column = position
    @grid[row][column]
  end

  def []=(position, value)
    row, column = position
    @grid[row][column] = value
  end

  def num_ships
    @grid.flatten.count(:S)
  end

  def attack(position)
    if self[position] == :S
      self[position] = :H
      puts "you sunk my battleship!"
      return true
    else
      self[position] = :X
      return false
    end
  end

  def place_random_ships
    twentyfive_percent = @size / 4
    row_length = @grid.length
    column_length = @grid[0].length

    while twentyfive_percent > 0
      rand_row = rand(0...row_length)
      rand_col = rand(0...column_length)
      rand_pos = [rand_row, rand_col]

      if self[rand_pos] != :S
        self[rand_pos] = :S
        twentyfive_percent -=1
      end
    end
  end

  def hidden_ships_grid
    @grid.map { |row| row.map { |square| if square == :S then :N else square end } }
  end

  def self.print_grid(grid)
    grid.each do |row|
      row.each_with_index do |square, index|
        print "#{ square }"
        if index == row.length - 1
          print "\n"
        else
          print " "
        end
      end
    end
  end

  def cheat 
    Board.print_grid(@grid)
  end

  def print
    Board.print_grid(hidden_ships_grid)
  end
end
