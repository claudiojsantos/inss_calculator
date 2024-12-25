require 'rails_helper'

RSpec.describe Applicant, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:document) }
    it { should validate_uniqueness_of(:document) }
    it { should validate_presence_of(:birth_date) }
    it { should validate_numericality_of(:salary).is_greater_than(0) }
    it { should validate_numericality_of(:inss_discount).is_greater_than_or_equal_to(0) }
  end

  describe 'associations' do
    it { should have_many(:addresses).dependent(:destroy) }
    it { should have_many(:contacts).dependent :destroy }
  end

  describe 'factory' do
    it 'has a valid factory' do
      applicant = build(:applicant)
      expect(applicant).to be_valid
    end
  end
end
