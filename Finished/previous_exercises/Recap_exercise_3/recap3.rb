def no_dupes?(array)
  no_repeat = []

  array.each do |ele|
    if array.count(ele) == 1
      no_repeat << ele
    end
  end
  
  no_repeat
end

def no_consecutive_repeats?(array)
  array.each_with_index do |ele, idx|
    if ele == array[idx + 1]
      return false
    end
  end

  true
end

def char_indices(string)
  char_hash = Hash.new

  string.each_char.with_index do |char, idx|
    if char_hash.has_key?(char)
      if !char_hash[char].include?(idx)
        char_hash[char] = char_hash[char] << idx
      end
    else
      char_hash[char] = [idx]
    end
  end

  char_hash
end

def longest_streak(string)
  longest = string[0]
  current_idx = 0
  temp = ""

  string.each_char.with_index do |char, idx|
    next if current_idx > idx
    temp = string[current_idx]
    
    if string[current_idx] == string[current_idx + 1]
      while string[current_idx] == string[current_idx + 1]
        temp += string[current_idx + 1]
        current_idx += 1
      end
    else
      current_idx += 1
    end
    
    longest = temp if temp.length >= longest.length
  end

  longest
end

def bi_prime?(num)
  prime_array = []
  Prime.each(num) do |prime|
    prime_array << prime
  end

  # compare
  prime_array.each_with_index do |prime, idx|
    compared_idx = idx;

    while compared_idx < prime_array.length
      if prime_array[idx] * prime_array[compared_idx] == num
        return true
      else
        compared_idx += 1
      end
    end
  end

  false
end

def vigenere_cipher(message, keys)
  alphabet = "abcdefghijklmnopqrstuvwxyz"
  encrypted_msg = ""
  current_idx = 0

  while current_idx < message.length
    keys.each do |num|
      new_idx = (alphabet.index(message[current_idx]) + num) % 26 
      encrypted_char = alphabet[new_idx]
      encrypted_msg += encrypted_char
      current_idx += 1

      break if current_idx >= message.length
    end
  end

  encrypted_msg
end

def vowel_rotate(str)
  vowels = "aeiou"
  modified_str = str.dup
  vowel_index = []
  vowel_array = []

  str.each_char.with_index do |char, idx|
    if vowels.include?(char)
      vowel_index << idx
      vowel_array << char
    end
  end

  vowel_array = vowel_array.rotate(-1)

  vowel_index.each do |idx|
    modified_str[idx] = vowel_array.shift
  end

  modified_str
end

class String
  def select
    return "" unless block_given?
    selected = ""

    self.each_char do |char|
      selected += char if yield(char) == true
    end

    selected
  end

  def map!
    self.each_char.with_index do |char, idx|
      self[idx] = yield(char, idx)
    end

    self
  end
end

def multiply(a, b)
  return a if b == 1
  return nil if b == 0

  if a >= 0 && b >= 0
    a + multiply(a, b - 1)
  elsif a < 0 && b < 0
    a.abs + multiply(a.abs, b.abs - 1)
  else
    -(a.abs) + multiply(-(a.abs), b.abs - 1)
  end
end

def lucas_sequence(num)
  return [] if num == 0
  return [2] if num == 1
  return [2,1] if num == 2

  sequence = lucas_sequence(num - 1)
  next_element = sequence[-1] + sequence[-2]
  sequence << next_element
  sequence
end

def prime_factorization(num)
  return [num] if Prime.prime?(num)

  prime_num = 1

  (2..num).each do |i|
    next unless i.prime?
    if num % i == 0
      prime_num = i
      num = num / i
      break
    end
  end

  [prime_num].push(*prime_factorization(num))
end