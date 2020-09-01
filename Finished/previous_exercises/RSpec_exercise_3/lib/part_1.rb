def is_prime?(num)
  return false if num < 2

  (2...num).each do |factor|
    return false if num % factor == 0
  end

  true
end

def nth_prime(num)
  return nil if num < 1

  count = 1
  prime = 2

  while count != num
    prime += 1
    count += 1 if is_prime?(prime)
  end

  prime
end

def prime_range(min, max)
  prime_array = []

  (min..max).each do |num|
    prime_array << num if is_prime?(num)
  end

  prime_array
end

