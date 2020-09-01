def my_map(array, &prc)
  new_arr = []

  array.each { |ele| new_arr << prc.call(ele) }

  return new_arr
end

def my_select(array, &prc)
  new_arr = []

  array.each { |ele| new_arr << ele if prc.call(ele) }

  return new_arr
end

def my_count(array, &prc)
  count = 0

  array.each { |ele| count += 1 if prc.call(ele) }

  return count
end

def my_any?(array, &prc)
  array.each { |ele| return true if prc.call(ele) }
  false
end

def my_all?(array, &prc)
  array.each { |ele| return false if !prc.call(ele) }
  true
end

def my_none?(array, &prc)
  array.each { |ele| return false if prc.call(ele) }
  true
end