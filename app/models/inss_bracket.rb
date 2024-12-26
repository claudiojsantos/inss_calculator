class InssBracket < ApplicationRecord
  validates :min_salary, :rate, presence: true
  validates :min_salary, numericality: { greater_than_or_equal_to: 0 }
  validates :max_salary, numericality: { greater_than: :min_salary }
  validates :rate, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
end
