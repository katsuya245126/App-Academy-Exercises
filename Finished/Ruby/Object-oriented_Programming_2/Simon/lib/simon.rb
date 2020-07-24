class Simon
  COLORS = %w[red blue green yellow].freeze

  attr_accessor :sequence_length, :game_over, :seq

  def initialize
    @sequence_length = 1
    @game_over = false
    @seq = []
  end

  def play
    loop do
      take_turn
      break if game_over
    end

    game_over_message
    reset_game
  end

  def take_turn
    show_sequence
    require_sequence
    round_success_message unless game_over
    @sequence_length += 1
  end

  def show_sequence
    add_random_color

    count_down
    seq.each do |color|
      puts color
      sleep(0.7)
      system('clear')
      sleep(0.3)
    end
  end

  def require_sequence
    seq.each do |color|
      print 'Please input the sequence: '
      input = gets.chomp

      if input != color
        @game_over = true
        return nil
      end

      system('clear')
    end
  end

  def add_random_color
    seq << COLORS.sample
  end

  def round_success_message
    puts 'You have successfully matched the sequence!'
    print 'Press Enter to go on to the next round'
    gets
  end

  def game_over_message
    puts 'You got the sequence wrong! Game Over!'
  end

  def reset_game
    @sequence_length = 1
    @game_over = false
    @seq = []
  end

  def count_down
    system('clear')

    3.downto(1) do |i|
      puts i
      sleep(0.7)
      system('clear')
    end
  end
end
