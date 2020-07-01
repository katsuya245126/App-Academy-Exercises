def reverser(string, &prc)
  reversed = string.reverse
  prc.call(reversed)
end

def word_changer(sentence, &prc)
  sentence.split(" ").map { |ele| prc.call(ele) }.join(" ")
end

def greater_proc_value(num, prc_1, prc_2)
  prc_1.call(num) > prc_2.call(num) ? prc_1.call(num) : prc_2.call(num)
end

def and_selector(array, prc_1, prc_2)
  new_arr = []

  array.each { |ele| new_arr << ele if prc_1.call(ele) && prc_2.call(ele) }

  return new_arr
end

def alternating_mapper(array, prc_1, prc_2)
  new_arr = []

  array.each_with_index do |ele, idx|
    idx.even? ? new_arr << prc_1.call(ele) : new_arr << prc_2.call(ele)
  end

  return new_arr
end