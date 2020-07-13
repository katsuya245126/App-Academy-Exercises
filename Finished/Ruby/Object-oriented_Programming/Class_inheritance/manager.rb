# frozen_string_literal: true

require_relative 'employee.rb'

class Manager < Employee
  attr_reader :employees

  def initialize(name, title, salary, boss)
    super(name, title, salary, boss)
    @employees = []
  end

  def bonus(multiplier)
    total = []

    @employees.each do |e|
      total += total_subordinates(e)
    end

    total.map(&:salary).inject(:+) * multiplier
  end

  def add_employee(employee)
    @employees << employee
  end

  private

  def total_subordinates(employee)
    return [employee] unless employee.is_a?(Manager)

    total = [employee]

    employee.employees.each do |e|
      total += total_subordinates(e)
    end

    total
  end
end

ned = Manager.new('Ned', 'Founder', 1_000_000, nil)
darren = Manager.new('Darren', 'TA Manager', 78_000, ned)
shawna = Employee.new('Shawna', 'TA', 12_000, darren)
david = Employee.new('David', 'TA', 10_000, darren)

ned.add_employee(darren)
darren.add_employee(shawna)
darren.add_employee(david)

p ned.bonus(5) # => 500_000
p darren.bonus(4) # => 88_000
p david.bonus(3) # => 30_000