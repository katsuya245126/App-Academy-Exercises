require_relative "code"

class Mastermind
  def initialize(length)
    @secret_code = Code.random(length)
  end

  def print_matches(guess_code)
    exact_matches = @secret_code.num_exact_matches(guess_code)
    near_matches = @secret_code.num_near_matches(guess_code)

    puts "exact matches: #{ exact_matches }"
    puts "near matches: #{ near_matches }"
  end

  def ask_user_for_guess
    puts "Enter a code"
    user_input = gets.chomp
    user_guess = Code.from_string(user_input)

    print_matches(user_guess)
    user_guess == @secret_code
  end
end
