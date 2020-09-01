# Write a method, compress_str(str), that accepts a string as an arg.
# The method should return a new str where streaks of consecutive characters are compressed.
# For example "aaabbc" is compressed to "3a2bc".

def compress_str(str)
  new_str = ""
  idx = 0

  while idx < str.length
    if str[idx] != str[idx + 1]
      new_str += str[idx]
    else
      count = 2

      while str[idx] == str[idx + count]
        count += 1
      end

      new_str += count.to_s + str[idx]
      idx += count - 1
    end

    idx += 1
  end

  return new_str
end

p compress_str("aaabbc")        # => "3a2bc"
p compress_str("xxyyyyzz")      # => "2x4y2z"
p compress_str("qqqqq")         # => "5q"
p compress_str("mississippi")   # => "mi2si2si2pi"
