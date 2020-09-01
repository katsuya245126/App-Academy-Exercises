def hipsterfy(word)
  vowel = "aeiou"

  word = word.reverse!.each_char.with_index do |char, idx|
    if vowel.include?(char)
      word[idx] = ""
      return word.reverse!  
    end
  end

  return word.reverse!
end

def vowel_counts(word)
  vowels = "aeiou"
  vowel_hash = Hash.new(0)
  word.downcase.each_char { |char| vowel_hash[char] += 1 if vowels.include?(char) }

  return vowel_hash
end

def caesar_cipher(msg, n)
  alphabet = ('a'..'z').to_a.join

  msg = msg.each_char.map do |char|
    if alphabet.include?(char)
      idx = alphabet.index(char) + n
      alphabet[idx % 26]
    else
      char
    end
  end

  return msg.join
end