FactoryBot.define do
  factory :applicant do
    name { Faker::Name.name }
    document { Faker::IdNumber.brazilian_citizen_number }
    birth_date { Faker::Date.birthday(min_age: 18, max_age: 65) }
    salary { Faker::Number.decimal(l_digits: 4, r_digits: 2) }
    inss_discount { 0.0 }
  end
end
