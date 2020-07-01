# notes
# it says [5,3] is safe but it's not

class NQueenProblem
  def initialize(n)
    @queen_count = n
    @board = Array.new(n) { Array.new(n, 0) }
  end

  def print_board
    puts ""
    @board.each { |row| p row }
    puts ""
  end

  # delete
  def clear_board
    @board = Array.new(@queen_count) { Array.new(@queen_count, 0) }
  end

  def safe?(pos)
    row, col = pos
    puts "row: #{safe_row?(pos)}, col: #{safe_col?(pos)}, diag: #{safe_diag?(pos)}"
    safe_row?(pos) && safe_col?(pos) && safe_diag?(pos)
  end

  def solve(n)
    return true if n >= @queen_count
    @board.each_with_index do |row, x|
      row.each_with_index do |col, y|
        puts "#{x}, #{y}"
        if safe?([x, y])
          @board[x][y] = 1
          print_board
          return true if solve(n + 1)

          @board[x][y] = 0
        end
      end
    end

    false
  end

  private

  def safe_row?(pos)
    row, col = pos
    @board[row].none?(1)
  end

  def safe_col?(pos)
    row, col = pos
    @board.length.times { |x| return false if @board[x][col] == 1 }
    true
  end

  def safe_diag?(pos)
    primary_diag(pos).none?(1) && secondary_diag(pos).none?(1)
  end

  def primary_diag(pos)
    row, col = pos
    arr = []

    # keep going NW ⬁ until you hit the border
    # I thought it would be easier to start from the first element rather than
    # going SW ⬂ from the current point and going back up
    until row == 0 || col == 0
      row -= 1
      col -= 1
    end
    
    # Keep going diagonally by adding +1 to row and col until it hits the border
    while valid_idx?([row, col])
      arr << @board[row][col]
      row += 1
      col += 1
    end

    arr
  end

  # same logic as primary diag except the directions are reversed
  def secondary_diag(pos)
    row, col = pos
    arr = []

    until row == 0 || col == @board.length - 1
      row -= 1
      col += 1
    end

    while valid_idx?([row, col])
      arr << @board[row][col]
      row += 1
      col -= 1
    end

    arr
  end

  def valid_idx?(pos)
    row, col = pos
    return false if row < 0 || col < 0
    @board.length > row && @board.length > col
  end
end
