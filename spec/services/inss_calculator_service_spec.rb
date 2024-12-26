require 'rails_helper'
require 'ostruct'

RSpec.describe InssCalculatorService do
  describe 'calculate' do
    let(:brackets) do
      [
        OpenStruct.new(min_salary: 0, max_salary: 1412.0, rate: 0.075.to_d),
        OpenStruct.new(min_salary: 1412.01, max_salary: 2666.68, rate: 0.09.to_d),
        OpenStruct.new(min_salary: 2666.69, max_salary: 3000.00, rate: 0.12.to_d)
      ]
    end

    before do
      allow(InssBracket).to receive_message_chain(:all, :order).and_return(brackets)
    end

    context 'when salary is within the first bracket' do
      it 'calculate the discount' do
        salary = BigDecimal("1051.0")

        discount = InssCalculatorService.calculate(salary)

        expected_discount = (salary * 0.075).truncate(2)

        expect(discount).to eq(expected_discount)
      end
    end

    context 'when multiple brackets' do
      it 'calculate the total discount' do
        salary = BigDecimal('3000.00')

        discount = InssCalculatorService.calculate(salary)

        discount_brk_1 = (BigDecimal('1412.0') * BigDecimal('0.075')).truncate(2)
        discount_brk_2 = ((BigDecimal('2666.68') - BigDecimal('1412.01')) * BigDecimal('0.09')).truncate(2)
        discount_brk_3 = ((BigDecimal('3000.0') - BigDecimal('2666.69')) * BigDecimal('0.12')).truncate(2)
        expect_discount = (discount_brk_1 + discount_brk_2 + discount_brk_3).truncate(2)

        expect(discount).to eq(expect_discount)
      end
    end
  end
end
