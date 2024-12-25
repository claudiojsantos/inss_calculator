class Address < ApplicationRecord
  belongs_to :applicant

  validates :address, presence: true
  validates :number, presence: true
  validates :neighborhood, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :city, presence: true
  validates :zip_code, presence: true
end
