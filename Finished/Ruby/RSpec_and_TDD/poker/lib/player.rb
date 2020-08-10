require_relative 'hand'

class Player
  attr_reader :hand, :pot

  def initialize(hand = Hand.new, pot = 100_000)
    @hand = hand
    @pot = pot
    @folded = false
  end

  def prompt_discard
    discard_message
    discards = gets.chomp.split(' ').map { |card| parse_cards(card) }
    return [] if discards.any? { |card| card == 'None' }

    hand.discard_card(discards)
  rescue RuntimeError => e
    case e.message
    when 'Invalid card detected'
      invalid_card_error
      retry
    when 'You can only discard 3 cards'
      discard_error
      retry
    when 'Card not in hand'
      no_card_error
      retry
    end
  end

  def prompt_turn
    turn_message
    command = gets.chomp

    case command
    when 'c' then :call
    when 'r' then :raise
    when 'f' then :fold
    else
      raise "You must type 'c', 'r', or 'f'"
    end
  end

  def parse_cards(str)
    parsed = str
    parsed = parsed.downcase
    parsed.capitalize
  end

  def receive_card(card)
    hand.add_card(card)
  end

  def return_hand
    current_hand = hand
    @hand = nil
    current_hand
  end

  def new_hand(hand)
    @hand = hand
  end

  def bet(amount)
    @pot -= amount
    amount
  end

  def win_pot(amount)
    @pot += amount
  end

  def fold
    @folded = true
  end

  def unfold
    @folded = false
  end

  def folded?
    @folded
  end

  def display_hand
    puts "current hand: #{hand}"
    puts
  end

  def discard_message
    display_hand
    puts 'Select up to three cards to discard separated with spaces or type none'
    print 'Choice: '
  end

  def turn_message
    puts 'call(c) raise(r) or fold(f)?'
    print 'Choice: '
  end

  def invalid_card_error
    print 'Please enter valid cards. Press Enter to continue...'
    gets
    puts
  end

  def discard_error
    print 'You can only choose 3 cards to discard. Press Enter to continue...'
    gets
    puts
  end

  def no_card_error
    print 'Please choose cards that are in your hand. Press Enter to continue...'
    gets
    puts
  end

  def card_count
    hand.cards.count 
  end
end
