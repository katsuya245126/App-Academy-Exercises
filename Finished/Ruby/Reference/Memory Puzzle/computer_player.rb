# Note
# How do I know if it's first turn or second turn?

class ComputerPlayer
  def initialize
    @name = "BOT"
    @known_cards = Hash.new
    @matched_cards = []
    @first_guess = true
  end

  def prompt(open_positions)
    puts "It's #{@name}'s turn! \nPlease enter the position of the card you would like to flip(e.g. '2,3'): "

    if @first_guess
      first_guess(open_positions)
    else
      second_guess(open_positions)
    end
  end

  def receive_revealed_card(pos, value)
    @known_cards[pos] = value
    @first_guess = !@first_guess
  end

  def receive_match(pos_1, pos_2)
    @known_cards.delete(pos_1)
    @known_cards.delete(pos_2)
    @matched_cards << [pos_1, pos_2]
  end

  private

  def first_guess(open_positions)
    matches? ? matching_pos.values.sample[0] : unseen_cards(open_positions).sample
  end

  def second_guess(open_positions)
    last_guess = @known_cards.to_a.last
    match = @known_cards.select { |k, v| v == last_guess[1] && k != last_guess[0] }
    if match.empty?
      return unseen_cards(open_positions).sample
    else 
      match.to_a[0][0]
    end
  end

  def unseen_cards(open_positions)
    open_positions.reject { |pos| @known_cards.include?(pos) }
  end

  def matches?
    !matching_pos.empty?
  end

  def matching_pos
    matching = @known_cards.group_by { |k, v| v }
    matching = matching.select { |k, v| v.length > 1 }
    matching = matching.map { |k, v| [k, [v[0][0], v[1][0]]] }.to_h
  end
end