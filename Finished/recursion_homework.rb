def sum_to(n)
  return nil if n < 0
  return 0 if n == 0
  n + sum_to(n-1)
end

def add_numbers(arr)
  return nil if arr.empty? 
  return arr[0] if arr.length == 1
  array = arr.dup
  first = array.shift

  first + add_numbers(array)
end

def gamma_fnc(n)
  return nil if n == 0
  return 1 if n == 1

  i = n - 1
  i * gamma_fnc(i)
end

def ice_cream_shop(arr, flavor)
  return false if arr.empty?
  return arr[0] == flavor if arr.length == 1

  flavor_array = arr.dup
  return true if flavor_array.shift == flavor
  ice_cream_shop(flavor_array, flavor)
end

def reverse(str)
  return str if str.length <= 1

  str[-1] + reverse(str[0...-1])
end