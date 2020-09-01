class Board
  def initialize
    @board = [
      ['_', '_', '_'],
      ['_', '_', '_'],
      ['_', '_', '_']
    ]
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

  def print
    puts ""
    puts "#{@board[0][0]} | #{@board[0][1]} | #{@board[0][2]}"
    puts "----------"
    puts "#{@board[1][0]} | #{@board[1][1]} | #{@board[1][2]}"
    puts "----------"
    puts "#{@board[2][0]} | #{@board[2][1]} | #{@board[2][2]}"
    puts ""
  end

  def win_row?(mark) 
    @board.each do |row|
      next if row.any? { |square| square == '_' }
      return true if row.all? { |square| square == mark }
    end

    false
  end

  def win_col?(mark)
    (0...@board[0].length).each do |row|
      current_column = []
      (0...@board.length).each do |column|
        current_column << @board[column][row]
      end

      next if current_column.any? { |square| square == '_' }
      return true if current_column.all? { |square| square == mark }
    end

    false
  end

  def win_diagonal?(mark)
    diagonal = []

    (0...@board.length).each { |i| diagonal << @board[i][i] }

    return false if diagonal.any? { |i| i == '_' }
    diagonal.all? { |square| square == mark } || win_anti_diagonal?(mark) ? true : false
  end

  def win_anti_diagonal?(mark)
    anti_diagonal = []

    (0...@board.length).each { |i| anti_diagonal << @board[i][(@board.length - 1) - i] }

    return false if anti_diagonal.any? { |i| i == '_' }
    anti_diagonal.all? { |square| square == mark }
  end

  def win?(mark)
    win_row?(mark) || win_col?(mark) || win_diagonal?(mark)
  end

  def empty_positions?
    @board.each { |row| return true if row.any? { |ele| ele == "_"} }
    false
  end
end