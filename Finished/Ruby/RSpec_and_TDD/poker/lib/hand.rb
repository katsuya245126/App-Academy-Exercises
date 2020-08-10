require_relative 'card'
require_relative 'poker_hands'

# Hand class
class Hand
  include PokerHands
  attr_reader :cards

  def initialize(cards = [])
    raise 'Hand too big' if cards.size > 5

    @cards = cards
  end

  def add_card(card)
    raise 'Not a card' unless card.is_a?(Card)
    raise 'Hand is full' if cards.size == 5

    cards << card
  end

  def discard_card(cards_to_discard)
    raise 'Invalid card detected' unless cards_to_discard.all? { |card| valid_card?(card) }
    raise 'You can only discard 3 cards' if cards_to_discard.count > 3

    discarded = []

    cards_to_discard.each do |face_value|
      found = cards.find { |card| card.to_s == face_value }
      raise 'Card not in hand' if found.nil?

      cards.delete(found)
      discarded << found
    end

    discarded
  end

  def valid_card?(face_value)
    if face_value.length == 2
      (('2'..'10').to_a + ['J', 'Q', 'K', 'A']).include?(face_value[0]) && %w[s h d c].include?(face_value[1])
    else
      face_value[0] + face_value[1] == '10' && %w[s h d c].include?(face_value[2])
    end
  end

  def <=>(other)
    case self.hand_strength <=> other.hand_strength
    when -1 then -1
    when 1 then 1
    when 0 then Hand.tie_breaker(self, other)
    end
  end

  def to_s
    str = ""
    cards.each { |card| str += "#{card} " }
    str
  end
end
