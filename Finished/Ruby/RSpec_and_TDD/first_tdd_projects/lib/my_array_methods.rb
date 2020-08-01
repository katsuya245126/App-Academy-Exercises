class MyArrayMethods
  def my_uniq(array)
    raise ArgumentError unless array.is_a?(Array)

    array.each_with_object([]) { |el, arr| arr << el unless arr.include?(el) }
  end

  def two_sum(array)
    pairs = []

    array.each_with_index do |ele, idx|
      (idx + 1...array.length).each do |idx2|
        pairs << [idx, idx2] if (ele + array[idx2]).zero?
      end
    end

    pairs
  end

  def my_transpose(array)
    raise ArgumentError unless array.is_a?(Array)

    transposed = []

    array.size.times do |y|
      new_row = []

      array.size.times { |x| new_row << array[x][y] }

      transposed << new_row
    end

    transposed
  end

  def stock_picker(prices)
    raise ArgumentError unless prices.is_a?(Array)

    profit = 0
    days = []

    prices.combination(2).each do |buy_price, sell_price|
      current_profit = sell_price - buy_price

      if current_profit > profit
        profit = current_profit
        days = [prices.find_index(buy_price), prices.find_index(sell_price)]
      end
    end

    days
  end
end
