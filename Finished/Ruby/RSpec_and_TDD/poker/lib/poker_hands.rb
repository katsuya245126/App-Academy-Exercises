# ugly code. Should fix
# I'll do it one day
# rubocop:disable all

module PokerHands
  def self.included(klass)
    klass.extend(ClassMethods)
  end

  module ClassMethods
    # returns hand_a <=> hand_b assuming they're both the same hand_strength
    def tie_breaker(hand_a, hand_b)
      raise 'Not a tie' unless hand_a.hand_strength == hand_b.hand_strength

      # If high_card, straight, flush, or straight flush just compare high value and kickers.
      # Should return 0 for straight since kickers are the same if high value is the same
      if [1, 5, 6, 9].include?(hand_a.hand_strength)
        hand_a.compare_highvalue_and_kicker(hand_a, hand_b)

      # if one pair or two pair, just compare the pairs and the kickers
      elsif [2, 3].include?(hand_a.hand_strength) 
        hand_a.compare_set_and_kickers(2, hand_a, hand_b)

      # if three of a kind compare the set and the kickers.
      elsif hand_a.hand_strength == 4
        hand_a.compare_set_and_kickers(3, hand_a, hand_b)

      # full house doesn't have any kickers so I had to compare sets twice
      # first compare the trips and then the dubs
      elsif hand_a.hand_strength == 7
        result = hand_a.compare_sets(hand_a.set(3), hand_b.set(3))
        return result unless result.zero?

        hand_a.compare_sets(hand_a.set(2), hand_b.set(2))
      else
        # if four of a kind, then just compare the set and kickers
        hand_a.compare_set_and_kickers(4, hand_a, hand_b)
      end
    end
  end

  # No need for royal flush since it's just straight flush
  def hand_strength
    raise nil unless cards.size == 5

    case 
    when straight_flush? then 9
    when four_kind? then 8
    when full_house? then 7
    when flush? then 6
    when straight? then 5
    when three_kind? then 4
    when two_pair? then 3
    when one_pair? then 2
    when high_card? then 1
    end
  end

  # creates an array of card values
  def highest_value
    cards.map(&:value).max
  end

  # If they have the same high card, compare kickers
  def compare_highvalue_and_kicker(hand_a, hand_b)
    result = hand_a.highest_value <=> hand_b.highest_value
    return result unless result.zero?

    compare_kickers(hand_a.kickers, hand_b.kickers)
  end

  def compare_set_and_kickers(set_num, hand_a, hand_b)
    result = compare_sets(hand_a.set(set_num), hand_b.set(set_num))
    return result unless result.zero?

    compare_kickers(hand_a.kickers, hand_b.kickers)
  end

  # returns an array of card values excluding sets/pairs
  def kickers
    card_values = cards.map(&:value)
    grouped = card_values.group_by(&:itself).values
    grouped.select { |pair| pair.size == 1 }.flatten
  end

  # Sorts the arrays by highest value and compares them a <=> b style. 
  # returns 0 if they're equal
  def compare_kickers(kickers_a, kickers_b)
    kickers_a.size.times do |idx|
      result = kickers_a.sort.reverse[idx] <=> kickers_b.sort.reverse[idx]
      return result unless result.zero?
    end

    0
  end

  # sorts the sets by highest pairs and compares the first element
  # returns 0 if all sets are equal
  def compare_sets(set_a, set_b)
    set_a.size.times do |idx|
      result = set_a.sort.reverse[idx][0] <=> set_b.sort.reverse[idx][0]
      return result unless result.zero?
    end

    0
  end

  # finds sets of n and returns them in an array by card values
  def set(n)
    card_values = cards.map(&:value)
    grouped = card_values.group_by(&:itself).values
    grouped.select { |pair| pair.size == n }
  end

  # If not flush or straight but unique 5 cards, then high cards
  def high_card?
    cards.uniq(&:value).size == 5 && !flush? && !straight?
  end

  # If unique 4 cards, one pair
  def one_pair?
    cards.uniq(&:value).size == 4
  end

  def two_pair?
    card_values = cards.map(&:value)
    # select elements that have a pair. If 2 pairs, return true
    # need to use uniq since it selects both of the pair elements
    card_values.select { |val| card_values.count(val) == 2 }.uniq.count == 2
  end

  def three_kind?
    card_values = cards.map(&:value)
    # find three same value cards. If found and the other 2 cards are unique, return true
    card_values.any? { |val| card_values.count(val) == 3 } && cards.uniq(&:value).size == 3
  end

  def straight?
    sorted = cards.map(&:value).sort
    # dealing with Ace
    # remove 14 from array if first element is two. This should work for A2345 hand
    sorted.pop if sorted.first == 2 && sorted.last == 14
    sorted.each_cons(2).all? { |a, b| a + 1 == b }
  end

  def flush?
    # if all suits are the same return true
    cards.uniq(&:suit).size == 1
  end

  def full_house?
    # Same with three_kind? but if other two hands are the same value, return trues
    card_values = cards.map(&:value)
    card_values.any? { |val| card_values.count(val) == 3 } && card_values.uniq.size == 2
  end

  def four_kind?
    card_values = cards.map(&:value)
    # if any value repeats itself four times return true
    card_values.any? { |val| card_values.count(val) == 4 }
  end

  def straight_flush?
    straight? && flush?
  end
end
