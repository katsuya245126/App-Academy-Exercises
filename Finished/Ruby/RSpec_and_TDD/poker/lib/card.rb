class Card
  attr_reader :value, :suit

  def initialize(value, suit)
    raise 'Invalid value and/or suit' unless valid_value?(value) && valid_suit?(suit)

    @value = value
    @suit = suit
  end

  def to_s
    "#{face_value(value)}#{suit}"
  end

  def ==(other)
    self.to_s == other.to_s
  end

  private

  def valid_value?(val)
    val.between?(2, 14)
  end

  def valid_suit?(suit)
    # spades, hearts, diamonds, clubs
    %w[s h d c].include?(suit)
  end

  def face_value(val)
    case val
    when 11 then 'J'
    when 12 then 'Q'
    when 13 then 'K'
    when 14 then 'A'
    else
      val.to_s
    end
  end

  def inspect
    "(value: #{value}, suit: #{suit})"
  end
end
