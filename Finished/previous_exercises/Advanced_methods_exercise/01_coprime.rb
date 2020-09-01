# Write a method, coprime?(num_1, num_2), that accepts two numbers as args.
# The method should return true if the only common divisor between the two numbers is 1.
# The method should return false otherwise. For example coprime?(25, 12) is true because
# 1 is the only number that divides both 25 and 12.

def divisible_by(num)
    divisors = []

    (2...num).each do |divisor|
        if num % divisor == 0
            divisors << divisor
        end
    end

    return divisors
end

def coprime?(num_1, num_2)
    num1_div = divisible_by(num_1)
    num2_div = divisible_by(num_2)

    num1_div.each do |divisor|
        if num2_div.include?(divisor)
            return false
        end
    end

    return true
end

p coprime?(25, 12)    # => true
p coprime?(7, 11)     # => true
p coprime?(30, 9)     # => false
p coprime?(6, 24)     # => false
