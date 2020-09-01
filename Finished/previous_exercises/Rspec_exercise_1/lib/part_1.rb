def average(num_1, num_2)
    return (num_1 + num_2) / 2.0
end

def average_array(array)
    return array.inject { |acc, ele| acc + ele } / array.length.to_f
end

def repeat(string, repeat)
    return string * repeat
end

def yell(string)
    return string.upcase + "!"
end

def alternating_case(sentence)
  split = sentence.split(" ").each_with_index.map { |word, idx| idx % 2 == 0 ? word.upcase : word.downcase }

  return split.join(" ")
end