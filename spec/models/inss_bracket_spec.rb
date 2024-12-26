require 'rails_helper'

RSpec.describe InssBracket, type: :model do
  let(:inss_bracker) { build(:inss_bracket, min_salary: 2000) }
  describe 'validations' do
    it { is_expected.to validate_presence_of(:min_salary) }
    it { is_expected.to validate_presence_of(:rate) }
    it { is_expected.to validate_numericality_of(:min_salary).is_greater_than_or_equal_to(0) }
    it { is_expected.to validate_numericality_of(:rate).is_greater_than_or_equal_to(0).is_less_than_or_equal_to(100) }

    it 'validates max_salary is greater than min_salary' do
      inss_bracker.max_salary = 4000
      expect(inss_bracker).to be_valid
      expect(inss_bracker.max_salary).to be > inss_bracker.min_salary
    end
  end
end
