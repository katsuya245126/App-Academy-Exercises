class HumanPlayer
  def initialize(mark)
    @mark = mark
  end

  def mark
    @mark
  end

  def get_position(legal_positions)
    puts "It's #{@mark}'s turn. Please input two numbers in the format 'row column': "
    player_input = gets.chomp

    until valid_input?(player_input) && legal_positions.include?(to_pos(player_input))
      puts "Invalid input! Try again in the format 'row column'"
      player_input = gets.chomp
    end

    to_pos(player_input)
  end

  def valid_input?(input)
    return false if input.length != 3
    nums = ("0".."9").to_a

    nums.include?(input[0]) && input[1] == " " && nums.include?(input[2])
  end

  def to_pos(string)
    [string[0].to_i, string[-1].to_i]
  end
end