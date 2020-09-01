def partition(array, n)
  new_array = [[],[]]
  array.each { |ele| ele < n ? new_array[0] << ele : new_array[1] << ele }

  new_array
end

def merge(hash_1, hash_2)
  hash_1.merge(hash_2)
end

def censor(sentence, curse_words)
  vowels = "aeiou"
  words = sentence.split(" ")

  words = words.map do |word| 
    if curse_words.include?(word.downcase)
      word.each_char.map { |char| vowels.include?(char.downcase) ? "*" : char}.join
    else
      word
    end
  end

  words.join(" ")
end

def power_of_two?(n)
  Math.log(n, 2) % 1 == 0 ? true : false
end
