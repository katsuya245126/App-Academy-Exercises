class HumanPlayer
  def prompt
    [prompt_pos, prompt_value]
  end

  def prompt_pos(_board)
    loop do
      print "Enter a position (e.g. 2,3): "
      pos = gets.chomp.split(",").map(&:to_i)
      return pos if valid_pos?(pos)
      input_error
    end
  end

  def prompt_value
    loop do
      print "Enter a number (1-9): "
      value = gets.chomp.to_i
      return value if valid_value?(value)
      input_error
    end
  end

  def valid_pos?(pos)
    return false if pos.size != 2
    pos.all? { |i| i.between?(0,8) }
  end

  def valid_value?(value)
    value.between?(1,9)
  end

  def input_error
    puts "\n Invalid input! Try again"
  end
end