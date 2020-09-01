require "byebug"

class Hangman
  DICTIONARY = ["cat", "dog", "bootcamp", "pizza"]

  def self.random_word
    DICTIONARY.sample
  end

  def initialize
    @secret_word = self.class.random_word
    @guess_word = Array.new(@secret_word.length, "_")
    @attempted_chars = []
    @remaining_incorrect_guesses = 5
  end 

  def guess_word
    @guess_word
  end

  def attempted_chars
    @attempted_chars
  end

  def remaining_incorrect_guesses
    @remaining_incorrect_guesses
  end

  def already_attempted?(char)
    @attempted_chars.include?(char)
  end

  def get_matching_indices(char)
    indices = []
    @secret_word.each_char.with_index { |word_char, idx| indices << idx if word_char == char }
    indices
  end

  def fill_indices(char, indices)
    indices.each do |index|
      @guess_word[index] = char
    end
  end

  def try_guess(try_char)
    if already_attempted?(try_char)
      puts "that has already been attempted"
      return false
    end

    @attempted_chars << try_char

    matching_indices = get_matching_indices(try_char)

    if matching_indices.empty?
      @remaining_incorrect_guesses -= 1
    else
      fill_indices(try_char, matching_indices)
    end

    return true
  end

  def ask_user_for_guess
    puts "Enter a char: "
    user_input = gets.chomp

    try_guess(user_input)
  end

  def win?
    if @guess_word.join == @secret_word
      puts "WIN"
      return true
    end

    false
  end

  def lose?
    if @remaining_incorrect_guesses == 0
      puts "LOSE"
      return true
    end

    false
  end

  def game_over?
    if win? || lose?
      puts @secret_word
      return true
    end

    false
  end
end
