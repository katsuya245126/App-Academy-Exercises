require "colorize"

class Tile
  attr_reader :given, :value

  def initialize(value, given)
    @value = value
    @given = given
  end

  def value=(new_value)
    return nil unless given

    @value = new_value
  end

  def to_s
    str = value.to_s
    return str.colorize(:white) if str == "0"

    given ? str.colorize(:cyan) : str.colorize(:yellow).bold
  end
end