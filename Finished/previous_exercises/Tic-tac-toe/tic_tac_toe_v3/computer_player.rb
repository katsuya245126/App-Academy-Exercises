class ComputerPlayer
  def initialize(mark)
    @mark = mark
  end

  def mark
    @mark
  end

  def get_position(legal_positions)
    pos = legal_positions.sample
    puts "BOT chooses #{pos}!"
    pos
  end
end