# Monkey-Patch Ruby's existing Array class to add your own custom methods
class Array
  def span
    if !self.empty? && self.all? { |ele| ele.is_a?(Integer) }
      return self.sort[-1] - self.sort[0]
    else
      nil
    end
  end

  def average
    return nil if self.empty?

    if self.all? { |ele| ele.is_a?(Integer) }
      self.sum.to_f / self.length
    end
  end

  def median
    return nil if self.empty?

    if self.length.odd?
      self.sort[self.length / 2]
    else 
      first_middle = self.sort[(self.length - 1) / 2]
      second_middle = self.sort[((self.length - 1) / 2) + 1]
      (first_middle + second_middle).to_f / 2
    end
  end

  def counts
    count = Hash.new(0)
    self.map { |ele| count[ele] += 1}
    count
  end

  def my_count(value)
    count = 0
    self.each { |ele| count += 1 if ele == value}
    count
  end

  def my_index(value)
    index = nil

    self.each_with_index do |ele, idx| 
      if ele == value 
        index = idx
        break
      end
    end

    index
  end

  def my_uniq
    not_uniq = []

    self.select do |ele| 
      if not_uniq.include?(ele)
        false
      else
        not_uniq << ele
        ele
      end
    end
  end

  def my_transpose
    transposed = []

    (0...self.length).each do |row|
      new_row = []

      (0...self[row].length).each do |index|
        new_row << self[index][row]
      end

      transposed << new_row
    end

    transposed
  end
end