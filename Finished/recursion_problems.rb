require 'byebug'
# Problem 1:

def sum_recur(array)
  return 0 if array.empty?

  array[0] + sum_recur(array[1..-1])
end

# Problem 2:

def includes?(array, target)
  return false if array.empty?

  current = array[0] == target
  previous = includes?(array[1..-1], target)

  current || previous
end

# Problem 3:

def num_occur(array, target)
  return 0 if array.empty?

  count = 0
  count += array[0] == target ? 1 : 0
  count + num_occur(array[1..-1], target)
end

# Problem 4:

def add_to_twelve?(array)
  return false if array.length < 2

  sum = array.take(2).sum == 12
  next_sum = add_to_twelve?(array[1..-1])
  sum || next_sum
end

# Problem 5:

def sorted?(array)
  return true if array.length <= 1

  comparison = array[0] <= array[1]
  next_comparison = sorted?(array[1..-1])
  comparison && next_comparison
end

# Problem 6:

def reverse(string)
  return string if string.length <= 1

  last_char = string[-1]
  remaining_str = reverse(string[0...string.length - 1])
  last_char + remaining_str
end
