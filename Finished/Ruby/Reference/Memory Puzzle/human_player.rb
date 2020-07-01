class HumanPlayer
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def prompt(open_positions)
    loop do 
      puts "It's #{@name}'s turn! \nPlease enter the position of the card you would like to flip(e.g. '2,3'): "
      pos = to_coordinate(gets.chomp)
      return pos if open_positions.include?(pos)
      puts "\n Invalid position. Please choose another position."
      puts ""
    end
  end

  def receive_revealed_card(pos, value)
    nil
  end

  def receive_match(pos_1, pos_2)
    nil
  end

  private

  def to_coordinate(string)
    [string[0].to_i, string[-1].to_i]
  end
end