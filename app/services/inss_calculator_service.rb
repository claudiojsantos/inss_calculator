require 'bigdecimal'
require 'bigdecimal/util'

class InssCalculatorService
  def self.calculate(salary)
    brackets = InssBracket.all.order(:min_salary)
    total_discount = BigDecimal('0.0')
    remaining_salary = BigDecimal(salary.to_s)

    brackets.each do |bracket|
      break if remaining_salary <= 0

      min_salary = BigDecimal(bracket.min_salary.to_s)
      max_salary = BigDecimal(bracket.max_salary.to_s) if bracket.max_salary

      base_salary = if max_salary
                            [ remaining_salary, max_salary - min_salary ].min
      else
                            remaining_salary
      end

      next if base_salary <= 0

      bracket_discount = (base_salary * BigDecimal(bracket.rate.to_s)).truncate(2)
      total_discount += bracket_discount

      remaining_salary -= base_salary
    end

    total_discount.truncate(2)
  end
end
