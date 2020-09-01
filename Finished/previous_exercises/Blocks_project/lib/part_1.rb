def select_even_nums(array)
  array.select(&:even?)
end

def reject_puppies(array)
  array.reject { |hash| hash["age"] < 3 }
end

def count_positive_subarrays(array)
  array.count { |ele| ele.inject(:+) > 0}
end

def aba_translate(str)
  str.each_char.map { |char| "aeiou".include?(char) ? (char + "b" + char) : (char) }.join 
end

def aba_array(array)
  array.map(&method(:aba_translate))
end