class HumanPlayer
  attr_accessor :previous_guess

  def initialize(_size)
    @previous_guess = nil
  end

  def get_input
    prompt
    pos = gets.chomp
    parse(pos)
  end

  def prompt
    puts "Please enter the position of the card you want to flip(e.g. 2,3): "
    print "> "
  end

  def parse(string)
    string = string.split(",").map { |i| i.to_i }
  end

  def receive_revealed_card(pos, value)
    # duck
  end

  def receive_match(pos1, pos2)
    # duck
  end
end