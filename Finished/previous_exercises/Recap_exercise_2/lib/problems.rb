# Write a method, least_common_multiple, that takes in two numbers and returns the smallest number that is a mutiple 
# of both of the given numbers
def least_common_multiple(num_1, num_2)
    (num_1 * num_2) / greatest_common_denominator(num_1, num_2)
end

def greatest_common_denominator(num_1, num_2)
    a = num_1
    b = num_2

    loop do 
        r = a % b
        a = b
        b = r

        break if b == 0
    end

    a
end

# Write a method, most_frequent_bigram, that takes in a string and returns the two adjacent letters that appear the
# most in the string.
def most_frequent_bigram(str)
    bigram_hash = Hash.new(0)

    (0...str.length - 1).each do |idx|
        bigram_hash[str[idx] + str[idx+1]] += 1
    end

    sorted = bigram_hash.sort_by { |k, v| v }
    sorted[-1][0]
end


class Hash
    # Write a method, Hash#inverse, that returns a new hash where the key-value pairs are swapped
    def inverse
        new_hash = {}
        self.each { |key, value| new_hash[value] = key }
        new_hash
    end
end


class Array
    # Write a method, Array#pair_sum_count, that takes in a target number returns the number of pairs of elements that sum to the given target
    def pair_sum_count(num)
        pairs = 0

        (0...self.length - 1).each do |idx|
            (idx + 1...self.length).each do |idx2|
                pairs += 1 if self[idx] + self[idx2] == num
            end
        end

        pairs
    end


    # Write a method, Array#bubble_sort, that takes in an optional proc argument.
    # When given a proc, the method should sort the array according to the proc.
    # When no proc is given, the method should sort the array in increasing order.
    def bubble_sort(&prc)
        prc ||= Proc.new { |a, b| a <=> b }
        self.sort! &prc
    end
end
