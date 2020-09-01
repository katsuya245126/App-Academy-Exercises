
def palindrome?(str)
  idx = -1
  
  str.each_char do |char|
    return false if char != str[idx]
    idx -= 1
  end

  true
end

def substrings(str) 
  substrings = []

  str.each_char.with_index do |char, index|
    substrings << char
    
    idx = index + 1
    while idx < str.length
      substrings << str[index..idx]
      idx += 1
    end
  end

  substrings
end

def palindrome_substrings(word)
  substrings(word).select { |ele| ele if palindrome?(ele) && ele.length > 1 }
end
