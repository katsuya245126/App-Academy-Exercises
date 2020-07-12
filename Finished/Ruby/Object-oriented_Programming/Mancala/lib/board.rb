class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @cups = place_stones(empty_cups)
    @player1 = name1
    @player2 = name2
    @current_player = nil
  end

  def valid_move?(start_pos)
    raise 'Invalid starting cup' unless valid_cup?(start_pos)
    raise 'Starting cup is empty' if cups[start_pos].empty?

    true
  end

  def make_move(start_pos, current_player_name)
    @current_player = current_player_name
    drop_path = drop_idx(start_pos, current_player_name)
    drop_path.each { |idx| cups[idx] << :stone }
    render
    next_turn(drop_path.last)
  end

  def next_turn(ending_cup_idx)
    # helper method to determine whether #make_move returns :switch, :prompt, or ending_cup_idx
    if ending_cup_idx == player_cup(@current_player)
      :prompt
    elsif cups[ending_cup_idx].count == 1
      :switch
    else
      ending_cup_idx
    end
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ''
    puts ''
  end

  def one_side_empty?
    (0..5).all? { |i| cups[i].empty? } || (7..13).all? { |n| cups[n].empty? }
  end

  def winner
    case cups[6] <=> cups[13]
    when 1 then player1
    when 0 then :draw
    when -1 then player2
    end
  end

  private

  attr_reader :player1, :player2

  def empty_cups
    Array.new(14) { [] }
  end

  def place_stones(unfilled_cups)
    unfilled_cups.each_with_index do |cup, idx|
      next if [6, 13].include?(idx)

      4.times { cup << :stone }
    end
  end

  def valid_cup?(idx)
    idx.between?(0, 5) || idx.between?(6, 13)
  end

  def clear_cup(idx)
    stones = cups[idx].count
    cups[idx].clear
    stones
  end

  def player_cup(current_player)
    case current_player
    when player1 then 6
    when player2 then 13
    end
  end

  def opponent_cup(current_player)
    case current_player
    when player1 then 13
    when player2 then 6
    end
  end

  def drop_idx(start_pos, player)
    opponent_idx = opponent_cup(player)
    stone_count = clear_cup(start_pos)
    current_idx = start_pos + 1
    idx_array = []

    until idx_array.count == stone_count
      current_idx = 0 if current_idx > 13

      idx_array << current_idx unless opponent_idx == current_idx
      current_idx += 1
    end

    idx_array
  end
end
