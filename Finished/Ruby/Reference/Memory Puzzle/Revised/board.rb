require_relative "card.rb"

class Board
  attr_reader :size

  def initialize(size)
    @board = Array.new(size) { Array.new(size) }
    # @size used in populate method
    @size = size
    populate
  end

  def [](pos)
    y, x = pos
    #getter for board is declared below in private section
    board[y][x]
  end

  def []=(pos, value)
    y, x = pos
    board[y][x] = value
  end

  def hide(pos)
    y, x = pos
    board[y][x].hide
  end

  def reveal(pos)
    y, x = pos

    if board[y][x].revealed?
      puts "That card is already face up."
    else
      board[y][x].reveal
    end

    board[y][x].value
  end

  def populate
    # board of 4x4 would need 8 pairs so 4**2 = 16 / 2 = 8, etc
    # it doesn't work with odd numbers
    num_pairs = (@size**2)/2
    card_pairs = Card.shuffled_pairs(num_pairs)

    # go through each space and pop a card in there
    board.each_with_index do |row, y|
      row.each_with_index do |col, x|
        board[y][x] = card_pairs.pop
      end
    end
  end

  def render
    puts ""
    puts "    0   1   2   3  "
    puts "  -----------------"

    board.each_with_index do |row, y|
      print "#{y} | "
      row.each_with_index do |col, x|
        print "#{col.to_s} | "
      end
      puts ""
      puts "  -----------------"
    end
    puts ""
  end

  # ?
  def revealed?(pos)
    self[pos].revealed?
  end

  # checks if all of the cards are revealed, which means you won
  def won?
    board.all? do |row|
      row.all?(&:revealed?)
    end
  end

  private

  attr_reader :board
end

