require_relative "board.rb"
require_relative "tile.rb"

class SudokuSolver
  attr_reader :board

  BOX_START_POS = {
    1 => [0,0],
    2 => [0,3],
    3 => [0,6],
    4 => [3,0],
    5 => [3,3],
    6 => [3,6],
    7 => [6,0],
    8 => [6,3],
    9 => [6,6],
  }

  def initialize(file_path)
    @board = Board.new(file_path)
  end

  def solve
    if solve_sudoku
      board.render
    else
      puts "No solution."
    end
  end

  def solve_sudoku
    return true if !find_empty_pos

    pos = find_empty_pos

    (1..9).each do |num|
      if safe_pos?(pos, num)
        board[pos] = num

        if solve_sudoku
          return true
        else
          board[pos] = 0
        end
      end
    end

    false
  end

  def find_empty_pos
    board.grid.each_with_index do |row, y|
      row.each_with_index do |tile, x|
        return [y, x] if tile.value == 0
      end
    end

    false
  end

  def safe_pos?(pos, num)
    !used_in_row?(pos, num) && !used_in_column?(pos, num) && !used_in_box?(pos, num)
  end

  def used_in_row?(pos, num)
    y, x = pos
    board.grid[y].any? { |tile| tile.value == num }
  end

  def used_in_column?(pos, num)
    y, x = pos
    board.grid.transpose[x].any? { |tile| tile.value == num }
  end

  def used_in_box?(pos, num)
    y, x = BOX_START_POS[box_num(pos)]

    3.times do |i|
      3.times do |n|
        return true if board[[y + i, x + n]].value == num
      end
    end

    false
  end

  def box_num(pos)
    y, x = pos

    (y / 3) * 3 + (x / 3) + 1
  end

  def refresh
    system("clear")
    board.render
  end
end