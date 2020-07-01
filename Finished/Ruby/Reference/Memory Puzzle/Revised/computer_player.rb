class ComputerPlayer
  attr_accessor :previous_guess, :board_size

  # board_size will be needed in #random_guess
  def initialize(size)
    @board_size = size
    @matched_cards = {}
    @known_cards = {} 
    @previous_guess = nil
  end

  # receive revealed card from the game class
  def receive_revealed_card(pos, value)
    @known_cards[pos] = value
  end

  # receive matched but only store position. value is not needed
  def receive_match(pos_1, pos_2)
    @matched_cards[pos_1] = true
    @matched_cards[pos_2] = true
  end

  # if previous guess exists, it means there was a guess before so it goes to second_guess
  def get_input
    if previous_guess
      second_guess
    else
      first_guess
    end
  end

  # method to find unmatched card inside @known_cards
  def unmatched_pos
    # running #find on hash returns an array, so we're just extracting the pos
    # since value is not needed 
    (pos, _) = @known_cards.find do |pos, val|
      @known_cards.each do |pos_2, val_2|
        # find a card that has matching values, different positions,
        # and not already in @matched_cards
        val == val_2 && pos != pos_2 && !(@matched_cards[pos] || @matched_cards[pos_2])
      end
    end

    pos
  end

  # method to find a card to match @previous_guess
  # similar to unmatched_pos
  def match_previous
    (pos, _) = @known_cards.find do |pos, val|
      pos != previous_guess && val == @known_cards[previous_guess] && 
        !@matched_cards[pos]
    end
  end

  # during the first guess it guesses known unmatched 
  # position if there are any otherwise random guess
  def first_guess
    unmatched_pos || random_guess
  end

  # during the second guess it tries to find a matching card to previous guess
  # if there are none, random_guess
  def second_guess
    match_previous || random_guess
  end

  def random_guess
    guess = nil

    # until guess is valid and is not in known_cards
    until guess && !@known_cards[guess]
      guess = [rand(board_size), rand(board_size)]
    end

    guess
  end
end