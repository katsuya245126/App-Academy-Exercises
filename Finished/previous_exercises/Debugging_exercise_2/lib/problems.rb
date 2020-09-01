# Run `bundle exec rspec` and satisy the specs.
# You should implement your methods in this file.
# Feel free to use the debugger when you get stuck.

# Run `bundle exec rspec` and satisy the specs.
# You should implement your methods in this file.
# Feel free to use the debugger when you get stuck.

def largest_prime_factor(num)
  divisors = []

  (1..num).each do |divisor|
    divisors << divisor if num % divisor == 0
  end

  divisors.reverse.each do |divisor|
    return divisor if prime?(divisor)
  end
end

def prime?(num)
  (2...num).each { |divisor| return false if num % divisor == 0}
  true
end

def unique_chars?(str)
  unique_chars = []

  str.each_char do |char|
    if unique_chars.include?(char)
      return false
    else
      unique_chars << char
    end
  end

  true
end

def dupe_indices(array)
  indices = {}

  array.each_with_index do |ele, idx|
    if indices.has_key?(ele)
      indices[ele] << idx
    else
      indices[ele] = [idx]
    end
  end

  return indices.select { |key, value| value.length > 1}
end

def ana_array(array_1, array_2)
  hash_1 = Hash.new(0)
  hash_2 = Hash.new(0)

  array_1.each { |ele| hash_1[ele] += 1 }
  array_2.each { |ele| hash_2[ele] += 1 }

  hash_1 == hash_2
end