# frozen_string_literal: true

# This is a class builds a chain of words connnecting the first word to the second
class WordChains
  ALPHABET = ('a'..'z').to_a

  def initialize(dict_file_path)
    @dictionary = File.read(dict_file_path).split("\n").to_set
  end

  def run(source, target)
    @current_words = [source]
    @all_seen_words = { source => nil }

    @current_words = explore_current_words until @current_words.empty? || @all_seen_words.include?(target)
    build_path(target)
  end

  private

  attr_reader :dictionary

  def adjacent_words(word)
    adjacent = []

    word.length.times do |i|
      ALPHABET.each do |char|
        next if word[i] == char

        test_word = word.dup
        test_word[i] = char

        adjacent << test_word if dictionary.include?(test_word)
      end
    end

    adjacent
  end

  def explore_current_words
    new_current_words = []
    @current_words.each do |word|
      adjacent_words(word).each do |adj_word|
        next if @all_seen_words.include?(adj_word)

        new_current_words << adj_word
        @all_seen_words[adj_word] = word
      end
    end

    new_current_words
  end

  def build_path(target)
    return nil unless @all_seen_words.include?(target)

    path = []
    from = target

    until from.nil?
      path << from
      from = @all_seen_words[from]
    end

    path.reverse
  end
end
