require "employee"

class Startup

  attr_reader :name, :funding, :salaries, :employees

  def initialize(name, funding, salaries)
    @name = name
    @funding = funding
    @salaries = salaries
    @employees = []
  end

  def valid_title?(title)
    @salaries.has_key?(title)
  end

  def > (another_startup)
    self.funding > another_startup.funding
  end

  def hire(employee_name, title)
    raise 'invalid title' if !self.valid_title?(title)

    new_employee = Employee.new(employee_name, title)
    @employees << new_employee
  end

  def size
    employees.length
  end

  def pay_employee(employee)
    salary = @salaries[employee.title]

    if salary <= @funding
      employee.pay(salary)
      @funding -= salary
    else
      raise "not enough funding"
    end
  end

  def payday
    @employees.each(&method(:pay_employee))
  end

  def average_salary
    total_salaries = self.employees.inject(0) { |sum, employee| sum + self.salaries[employee.title] }
    number_of_employees = self.employees.length

    total_salaries / number_of_employees
  end

  def close
    @employees = []
    @funding = 0
  end

  def acquire(other_startup)
    @funding += other_startup.funding

    other_startup.salaries.each do |title, salary|
      if !@salaries.has_key?(title)
        @salaries[title] = salary
      end
    end

    @employees.concat(other_startup.employees)
    other_startup.close
  end
end
