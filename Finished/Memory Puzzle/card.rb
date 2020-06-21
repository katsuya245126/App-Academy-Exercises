require_relative "board.rb"
require_relative "game.rb"

class Card
  attr_reader :value, :hidden

  def initialize(value)
    @value = value
    @hidden = true
  end

  def hide
    @hidden = true
  end

  def reveal
    @hidden = false
    @value
  end

  def display
    @hidden ? " " : @value
  end

  def to_s
    puts "Value: #{@value}, hidden: #{@hidden}"
  end

  def ==(other)
    self.value == other.value
  end
end