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

    def >(startup)
        self.funding > startup.funding
    end

    def hire(employee_name, title)
        if self.valid_title?(title)
            employee = Employee.new(employee_name, title)
            @employees << employee
        else
            raise "The title is unavailable"
        end
    end

    def size
        @employees.length
    end

    def pay_employee(employee)
        employee_salary = @salaries[employee.title]

        if @funding >= employee_salary
            employee.pay(employee_salary)
            @funding -= employee_salary
        else
            raise "Not enough funds to pay the employee"
        end
    end

    def payday
        @employees.each { |employee| pay_employee(employee) }
    end

    def average_salary
        sum = 0

        @employees.each do |employee|
            sum += @salaries[employee.title]
        end

        sum / (@employees.length * 1.0)
    end

    def close
        @employees = []
        @funding = 0
    end

    def acquire(another_startup)
        @funding += another_startup.funding

        another_startup.salaries.each do |title, salary|
            @salaries[title] = salary if !@salaries.has_key?(title)
        end

        @employees += another_startup.employees

        another_startup.close
    end
end
