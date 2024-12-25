require 'rails_helper'

RSpec.describe Address, type: :model do
  describe "validations" do
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:number) }
    it { should validate_presence_of(:neighborhood) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zip_code) }
  end

  describe 'associations' do
    it { should belong_to(:applicant) }
  end

  describe 'factory' do
    it 'has a valid factory' do
      address = build(:address)
      expect(address).to be_valid
    end
  end
end
