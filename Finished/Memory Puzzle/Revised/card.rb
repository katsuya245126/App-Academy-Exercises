class Card
  # values for cards
  # using a constant here since I don't need to make an instance of card to use this variable
  VALUES = ("A".."Z").to_a

  # class method to return shuffled pairs of values selected randomly in an array
  def self.shuffled_pairs(num_pair)
    # I get a warning if I don't assign VALUES to local variable
    values = VALUES
    values = values.shuffle.take(num_pair) * 2
    values.map { |val| Card.new(val) }.shuffle
  end

  attr_reader :value

  def initialize(value, revealed = false)
    @value = value
    @revealed = revealed
  end

  def hide
    @revealed = false
  end

  def reveal
    @revealed = true
  end

  def revealed?
    @revealed
  end

  def to_s
    revealed? ? value : " "
  end

  def ==(obj)
    self.value == obj.value
  end
end