class Applicant < ApplicationRecord
  has_many :addresses, dependent: :destroy
  has_many :contacts, dependent: :destroy

  accepts_nested_attributes_for :addresses, :contacts, allow_destroy: true

  validates :name, presence: true
  validates :document, presence: true, uniqueness: true
  validates :birth_date, presence: true
  validates :salary, numericality: { greater_than: 0 }
  validates :inss_discount, numericality: { greater_than_or_equal_to: 0 }

  after_create :enqueue_inss_discount_calculation, if: -> { inss_discount.zero? || inss_discount.nil? }

  private

  def enqueue_inss_discount_calculation
    InssCalculatorJob.perform_later(self.salary, self.id)
  end
end
