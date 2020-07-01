class Map
  def initialize
    @map = []
  end

  def set(key, value)
    index = map.find_index { |pair| pair[0] == key }

    index.nil? ? map << [key, value] : map[index][1] = value
  end

  def get(key)
    map.each do |pair|
      k = pair[0]
      return pair[1] if k == key
    end
    nil
  end

  def delete(key)
    map.reject! { |pair| pair[0] == key }
  end

  def show
    map
  end

  private

  attr_accessor :map
end
