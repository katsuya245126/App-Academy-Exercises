class Code
  POSSIBLE_PEGS = {
    "R" => :red,
    "G" => :green,
    "B" => :blue,
    "Y" => :yellow
  }

  attr_reader :pegs

  def self.valid_pegs?(chars_array)
    chars_array.all? { |char| POSSIBLE_PEGS.has_key?(char.upcase) }
  end

  def initialize(peg_array)
    if self.class.valid_pegs?(peg_array)
      @pegs = peg_array.map(&:upcase)
    else
      raise "Non-valid pegs. Choose R, G, B, or Y"
    end
  end

  def self.random(length)
    new_pegs = []
    length.times do 
      random_peg = POSSIBLE_PEGS.keys.sample
      new_pegs << random_peg
    end
    Code.new(new_pegs)
  end

  def self.from_string(pegs_string)
    pegs_array = pegs_string.split("")
    Code.new(pegs_array)
  end

  def [](idx)
    @pegs[idx]
  end

  def length
    @pegs.length
  end

  def num_exact_matches(guess)
    guess_pegs = guess.pegs
    matches = 0

    guess_pegs.each_with_index do |char, idx|
      matches += 1 if char == self[idx]
    end

    matches
  end

  def num_near_matches(guess_code)
    near_matches = 0

    guess_code.pegs.each_with_index do |char, idx|
      if char != self[idx] && self.pegs.include?(char)
        near_matches += 1
      end
    end

    near_matches
  end

  def ==(other_code)
    self.length == other_code.length && self.pegs == other_code.pegs
  end
end
