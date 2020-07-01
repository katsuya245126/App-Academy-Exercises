require 'byebug'

def range(start, last)
  return [] if start > last
  return [start] if start == last

  [start] + range(start + 1, last)
end

def exp_1(b, n)
  return 1 if n == 0

  b * exp_1(b, n - 1)
end

def exp_2(b, n)
  return 1 if n == 0

  if n % 2 == 0
    even = exp_2(b, n / 2)
    even * even
  else
    odd = exp_2(b, (n - 1) / 2)
    b * odd * odd
  end
end

class Array
  def deep_dup
    return self.dup unless self.any? { |el| el.is_a?(Array) }

    self.map do |el|
      el.is_a?(Array) ? el.deep_dup : el
    end
  end
end

def recursive_fibonacci(n)
  return [0,1].take(n) if n <= 2

  previous_fib = recursive_fibonacci(n - 1)
  previous_fib + [previous_fib[-1] + previous_fib[-2]]
end

def iterative_fibonacci(n)
  base = [0,1]
  return base.take(n) if n <= 2

  until n == 2
    base += [base[-1] + base[-2]]
    n -= 1
  end

  base
end

def bsearch(array, target)
  # the two base cases are when the array is empty and the middle of array is the target
  return nil if array.empty?
  mid = array.length / 2
  return mid if array[mid] == target

  if array[mid] > target
    # if the middle element is bigger than the target, take the left side of array
    left_sub = array[0...mid]
    # We can just call bsearch here because even if we take the left sub array,
    # the index will stay the same for the left side. The problem is with the right side
    return bsearch(left_sub, target)
  else
    # if the middle element is less than the target, take the right side of array
    # we need to add 1 to mid since we need to exclude it from the sub array
    right_sub = array[(mid + 1)...array.length]

    # need to check for nil here because if we don't, we end up doing arithmetic on nil
    # which causes NoMethodError or TypeError
    result = bsearch(right_sub, target)
    return nil if result == nil

    # when we take right sub array, the indexes gets messed up 
    # i.e [0,1,2,3,4,5] mid = array.length / 2 => 3
    #             [4,5] = right sub array
    # to make up for this fact, we add result to mid, since element 4 is basically
    # array[mid + 1] in original array. However, when we take the sub array, we
    # exclude mid from it so it ends up returning 0, which leads 
    # to array[mid + 0] so we need to add 1 at the end
    return mid + result + 1
  end
end

def merge_sort(array)
  return array if array.length <= 1

  left, right = array.each_slice((array.length / 2.0).round).to_a
  sorted_left = merge_sort(left)
  sorted_right = merge_sort(right)

  merge(sorted_left, sorted_right)
end

def merge(a, b)
  merged = []

  until a.empty? && b.empty?
    case a.first <=> b.first
    when -1
      merged << a.shift
    when 0
      merged.push(a.shift, b.shift)
    when 1
      merged <<  b.shift
    else
      # It shold come to here when one array is empty but there is one element left in other
      # array. So it becomes something like nil <=> 3, which returns nil
      # I check whichever array is not empty and shift the last element out
      last = a.empty? ? b.shift : a.shift
      merged << last
    end
  end

  merged
end

def subset(array)
  return [array] if array.empty?
  
  # Alright, so let me explain what's going on here. I've noticed a pattern in the subsets
  
  # subsets([])        =>   [[]]
  # subsets([1])       =>   [[], [1]]
  # subsets([1,2])     =>   [[], [1], [2], [1, 2]]
  # subsets([1, 2, 3]) =>   [[], [1], [2], [1, 2], [3], [1, 3], [2, 3], [1, 2, 3]]
  
  # as you can see, you are just adding the last element of the array to the previous subset
  # and adding the result to the previous subset

  # subsets([1])       =>   [[], [1]]
  # subsets([1,2])     =>   last element = 2
  #                    =>   add last element to the previous subset
  #                    =>   [[] << 2, [1] << 2] = [[2], [1,2]]
  #                    =>   now add it to previous subset
  #                    =>   [[], [1]] + [[2], [1,2]] = [[], [1], [2], [1, 2]]
  # Thanks for coming to my TED talk
  lesser_subset = subset(array[0...-1])
  # array needs to be dup in the block otherwise it ends up modifying lesser_subset
  insert_last = lesser_subset.map { |arr| arr.dup << array.last }
  lesser_subset + insert_last
end

def permutations(array)
  return [array] if array.length <= 1
  first = array[0]
  sub_perms = permutations(array[1..-1])
  
  # From stack overflow
  # this part returns "sub_perms" with "first" inserted into them
  # Example: 
  # array = [1,2]
  # first = 1
  # sub_perms = [2] due to base case
  # insert "first" below
  # v      v
  # [2]  [2] 
  # which would equal to [1,2] and [2,1]
  # insert into result and return [[1,2], [2,1]]
  sub_perms.each_with_object([]) do |perm, result|
    (0..perm.length).each { |i| result << perm.dup.insert(i, first) }
  end
end

def greedy_make_change(change, coins)
  return [] if change < coins.min
  used_coin = coins.find { |coin| change > coin }
  remaining_change = change - used_coin

  [used_coin] + greedy_make_change(remaining_change, coins)
end

# Example run of this method starting line 209
def make_better_change(change, coins)
  # base case would be if the change exactly matched one of the coins
  # it would simple return the coin and it would be the least amount of coins
  return [change] if coins.include?(change)

  # filter out any coins that are greater than the change
  # we also need an array to compare possible solutions
  usable_coins = coins.select { |coin| coin <= change }
  possible_solutions = []
  
  # loop through the usable coins and make possible combinations
  usable_coins.each do |coin|
    remainder_coins = usable_coins.select { |i| i <= coin }
    remainder_change = change - coin

    # rescuing exception
    begin
      # make_better_change will return nil if there is no possible solution
      # so it would be nil + [coin], which would result in NoMethodError	
      possible_solution = make_better_change(remainder_change, remainder_coins) + [coin]
    rescue NoMethodError
      return nil
    end

    possible_solutions << possible_solution
  end

  possible_solutions.sort_by(&:length).first
end

# make_better_change(14, [10, 7, 1])
#
# ########## change:14 ########## coins: [10, 7, 1] ##########
# FIRST ITERATION OF usable_coins.each where coin = 10
# usable_coins: [10, 7, 1]
# "selected coin: 10"
# "remainder_coins: [10, 7, 1]"
# "remainder_change: 4"
# possible_solution: make_beter_change(4, [1]) + [10]
#                  : [1,1,1,1] + [10] = > [1,1,1,1,10]

# ########## change:4 ########## coins: [10, 7, 1] ##########
# usable_coins: [1]
# "selected coin: 1"
# "remainder_coins: [1]"
# "remainder_change: 3"
# possible_solution: make_better_change(3, [1]) + [1]
#                  : [1,1,1] + [1] => [1,1,1,1]

# ########## change:3 ########## coins: [1] ##########
# usable_coins: [1]
# "selected coin: 1"
# "remainder_coins: [1]"
# "remainder_change: 2"
# "possible_solution: make_better_change(2, [1]) + [1]
#                   : [1,1] + [1] => [1,1,1]

# ########## change:2 ########## coins: [1] ##########
# usable_coins: [1]
# "selected coin: 1"
# "remainder_coins: [1]"
# "remainder_change: 1"
# possible_solution: make_better_change(1, [1]) + [1]
#                   : [1] + [1] => [1,1]

# ########## change:1 ########## coins: [1] => returns base case [1]

# SECOND ITERATION OF usable_coins.each where coin = 7
# "selected coin: 7"
# "remainder_coins: [7, 1]"
# "remainder_change: 7"
# "possible_solution: make_better_change(7, [7,1]) + [7]
#                   : [7] + [7] => [7,7]

# ########## change:7 ########## coins: [7, 1] => returns base case [7]

# Won't do third iteration since it only return [1]'s

