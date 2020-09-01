class Board
  WIN_COUNT = 3

  def initialize(n)
    @board = []
    n.times do
      row = []

      n.times do
        row << '_'
      end
      
      @board << row
    end
  end

  def valid?(position)
    row, col = position
    return false if row < 0 || col < 0
    (row < @board.length) && (col < @board[0].length)
  end

  def empty?(position)
    row, col = position
    @board[row][col] == '_'
  end

  def place_mark(position, mark)
    row, col = position
    if empty?(position) && valid?(position)
      @board[row][col] = mark
      true
    else
      raise "invalid mark"
    end 
  end

  def print_board
    puts ""
    @board.each_with_index do |row, row_num|
      row.each_with_index do |col, col_num|
        print " #{@board[row_num][col_num]} "
        unless col_num == row.length - 1
          print "|"
        else
          puts ""
        end
      end

      # create horizontal line between rows except for the last row
      unless row_num == @board.length - 1
        row.length.times do
          print "----"
        end
      end

      puts ""
    end
    puts ""
  end

  def consecutive?(array, mark)
    array.chunk { |grid| grid == mark }.each do |arr|
      return true if arr[0] == true && arr[1].length >= WIN_COUNT
    end
    false
  end

  def win_row?(mark) 
    @board.each do |row|
      return true if consecutive?(row, mark)
    end
    false
  end

  def win_col?(mark)
    (0...@board[0].length).each do |row|
      current_column = []
      (0...@board.length).each do |column|
        current_column << @board[column][row]
      end

      return true if consecutive?(current_column, mark)
    end

    false
  end

  def win_diagonal?(mark)
    diagonals = left_diagonals(@board) + right_diagonals(@board)
    diagonals = diagonals.select { |diag| diag.length >= WIN_COUNT }

    diagonals.any? { |diag| consecutive?(diag, mark) }
  end

  def left_diagonals(board)
    diagonals_array = []

    board.each_with_index do |row, row_idx|
      row.each_with_index do |col, col_idx|
        # I am couting the diaonals this way: 🡖
        # No need to count the other half after the first row
        next if row_idx > 0 && col_idx > 0

        diagonal = []
        i = 0

        # making sure to stay within bounds
        while row_idx + i < board.length && col_idx + i < board.length
          diagonal << board[row_idx + i][col_idx + i]
          i += 1
        end

        diagonals_array << diagonal
      end
    end

    diagonals_array
  end

  def right_diagonals(board)
    diagonals_array = []

    # couting from the bottom row
    board.each_with_index.reverse_each do |row, row_idx|
      row.each_with_index do |col, col_idx|
        # This time i am going this way: 🡕 
        # no need to count the other half after the first row
        next if row_idx < board.length - 1 && col_idx > 0

        diagonal = []
        i = 0

        # making sure to stay within bounds
        # I am substracting from i this time
        while row_idx + i >= 0 && col_idx + i.abs < board.length
          diagonal << board[row_idx + i][col_idx + i.abs]
          i -= 1
        end

        diagonals_array << diagonal
      end
    end

    diagonals_array
  end

  def win?(mark)
    win_row?(mark) || win_col?(mark) || win_diagonal?(mark)
  end

  def empty_positions?
    @board.each { |row| return true if row.any? { |ele| ele == "_"} }
    false
  end

  def legal_positions
    positions = []

    @board.each_with_index do |row, row_idx|
      row.each_with_index do |mark, col_idx|
        positions << [row_idx, col_idx] if mark == "_"
      end
    end

    positions
  end
end