class Employee
  attr_reader :name, :title, :salary, :boss

  def initialize(name, title, salary, boss)
    @name = name
    @title = title
    @salary = salary
    @boss = boss
    boss.add_employee(self) unless boss.nil?
  end

  def bonus(multiplier)
    bonus = @salary * multiplier
  end

end

class Manager < Employee
  attr_accessor :employees

  def initialize(name, title, salary, boss, employees = [])
    @employees = employees
    super(name, title, salary, boss)
  end

  def add_employee(employee)
    @employees << employee
  end

  def bonus(mulitplier)
    get_salary * mulitplier
  end

  def get_salary
    sum = 0
    @employees.each do|emp|
      if emp.is_a?(Manager)
        sum += emp.salary + emp.get_salary
      else
        sum += emp.salary
      end
    end

    sum
  end
end
