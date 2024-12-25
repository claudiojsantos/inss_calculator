require 'rails_helper'

RSpec.describe Contact, type: :model do
  describe 'validations' do
    it { should belong_to(:applicant) }
  end

  describe 'validations' do
    it { should validate_presence_of(:value) }

    it 'defines the correct enum for contact_type' do
      expect(Contact.contact_types).to eq({
                                            'residential' => 0,
                                            'mobile' => 1,
                                            'commercial' => 2,
                                            'whatsapp' => 3,
                                            'email' => 4
                                          })
    end
  end

  describe 'factory' do
    it 'has a valid factory' do
      contact = build(:contact)
      expect(contact).to be_valid
    end
  end
end
