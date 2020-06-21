class Node
  attr_accessor :f, :g, :h, :parent
  attr_reader :position

  def initialize(parent, position)
    @parent = parent
    @position = position
    @f = 0
    @g = 0
    @h = 0
  end

  def ==(other)
    self.position == other.position
  end

  def print
    puts "Position: #{@position}, f: #{@f}"
  end
end