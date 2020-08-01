class TowersOfHanoi
  attr_reader :rods

  def initialize
    @rods = [[3, 2, 1], [], []]
  end

  def play
    until won?
      render
      pos = [0, 0]

      begin
        pos = prompt
      rescue ArgumentError, NoMethodError
        puts "\nInvalid positions. Enter a number between 0 and 2\n\n"
        retry
      end

      next unless valid_move?(pos)

      make_move(pos)
    end

    puts 'You win!'
  end

  def render
    puts
    p @rods[0]
    p @rods[1]
    p @rods[2]
    puts
  end

  def make_move(pos)
    from, to = pos
    disc = @rods[from].pop
    @rods[to] << disc
  end

  def won?
    return false unless @rods.last.count == 3

    @rods.last == @rods.last.sort.reverse
  end

  private

  def prompt
    print 'Enter rod to take from: '
    from = parse(gets.chomp)
    print 'Enter rod to move to: '
    to = parse(gets.chomp)

    raise ArgumentError unless valid_pos?([from, to])

    [from, to]
  end

  def parse(num)
    Integer(num)
  end

  def valid_pos?(pos)
    return false unless pos.is_a?(Array)

    pos.all? { |i| i.is_a?(Integer) && i.between?(0, 2) }
  end

  def valid_move?(pos)
    from, to = pos
    return false if rods[from].empty?
    return true if rods[to].empty?

    rods[from].last < rods[to].last
  end
end
