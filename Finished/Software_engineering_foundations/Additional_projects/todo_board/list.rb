require_relative "item.rb"

class List
  attr_accessor :label

  def initialize(label)
    @label = label
    @items = []
  end

  def add_item(title, deadline, description = "")
    return false unless Item.valid_date?(deadline)

    @items << Item.new(title, deadline, description)
    true
  end

  def size
    @items.length
  end

  def valid_index?(idx)
    idx >= 0 && idx <= @items.length - 1
  end

  def swap(idx1, idx2)
    if valid_index?(idx1) && valid_index?(idx2)
      @items[idx1], @items[idx2] = @items[idx2], @items[idx1]
      return true
    end

    false
  end

  def [](idx)
    return @items[idx] if valid_index?(idx)
    nil
  end

  def priority
    @items[0]
  end

  def print
    puts "-".ljust(73, "-")
    puts @label.center(73)
    puts "-".ljust(73, "-")

    puts "#{"index".center(10)}|"\
    "#{"to do".center(30)}|"\
    "#{"deadline".center(20)}|"\
    "#{"Done".center(10)}"

    puts "-".ljust(73, "-")

    @items.each_with_index do |item, idx|
      puts "#{idx.to_s.center(10)}|"\
      "#{item.title.center(30)}|"\
      "#{item.deadline.center(20)}|"\
      "#{item.done? ? "✓".center(10) : ""}"
    end

    puts "-".ljust(73, "-")
  end

  def print_full_item(idx)
    return unless valid_index?(idx)

    puts "-".ljust(65, "-")

    puts "#{@items[idx].title.ljust(25)}"\
    "#{@items[idx].done? ? "DONE".center(15) : "NOT DONE".center(15)}"\
    "#{@items[idx].deadline.rjust(25)}"
    puts ""

    puts "#{@items[idx].description.center(65)}"

    puts "-".ljust(65, "-")
  end

  def print_priority
    print_full_item(0)
  end

  def up(idx, amount = 1)
    return false unless valid_index?(idx)

    current_idx = idx

    until current_idx == 0 || current_idx == idx - amount
      @items[current_idx - 1], @items[current_idx] = @items[current_idx], @items[current_idx - 1]
      current_idx -= 1
    end

    true
  end

  def down(idx, amount = 1)
    return false unless valid_index?(idx)

    current_idx = idx

    until current_idx == @items.length - 1 || current_idx == idx + amount
      @items[current_idx], @items[current_idx + 1] = @items[current_idx + 1], @items[current_idx]
      current_idx += 1
    end

    true
  end

  def sort_by_date!
    @items.sort_by! { |item| item.deadline }
  end

  def toggle_item(idx)
    @items[idx].toggle
  end

  def remove_item(idx)
    return false unless valid_index?(idx)
    @items.delete_at(idx)
    true
  end

  def purge
    @items.select! { |item| !item.done? }
  end
end