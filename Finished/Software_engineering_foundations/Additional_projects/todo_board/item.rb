class Item
  attr_accessor :title, :deadline, :description

  def self.valid_date?(date_string)
    date_array = date_string.split("-")
    months = (1..12).to_a
    days = (1..31).to_a

    date_array.each_with_index do |num, idx|
      if idx == 0
        num.match(/^[1-2][0-9]{3}$/) ? next : break
      elsif idx == 1
        months.include?(num.to_i) ? next : break
      else
        return true if days.include?(num.to_i)
      end
    end

    false
  end

  def done?
    @done
  end

  def initialize(title, deadline, description = "")
    @title = title
    @description = description
    raise "Invalid deadline!" unless self.class.valid_date?(deadline)
    @deadline = deadline
    @done = false
  end

  def deadline=(new_deadline)
    raise "Invalid date!" unless self.class.valid_date?(new_deadline)
    @deadline = new_deadline
  end

  def toggle
    @done = !@done
  end
end