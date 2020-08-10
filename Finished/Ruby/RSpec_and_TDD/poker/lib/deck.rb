require_relative 'card'

class Deck
  attr_accessor :cards

  def initialize
    @cards = make_full_deck
  end

  def take_card
    cards.pop
  end

  def return_card(card)
    raise 'That card is already in the deck' if cards.include?(card)

    cards.unshift(card)
  end

  def shuffle
    cards.shuffle!
  end

  private

  def make_full_deck
    cards = []

    4.times do |suit_idx|
      (2..14).each do |value|
        card = make_card(value, suit_idx)
        cards << card
      end
    end

    cards
  end

  def make_card(value, suit_idx)
    suit = suit(suit_idx)
    Card.new(value, suit)
  end

  def suit(idx)
    case idx
    when 0 then 's'
    when 1 then 'h'
    when 2 then 'd'
    when 3 then 'c'
    end
  end
end
