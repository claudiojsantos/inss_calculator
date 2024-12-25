FactoryBot.define do
  factory :contact do
    contact_type { Contact.contact_types.values.sample }
    value { Faker::PhoneNumber.phone_number }
    applicant
  end
end
