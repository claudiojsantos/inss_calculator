User.create!([
  { name: 'Admin', email: 'admin@test.com', password: '12345678' }
])

InssBracket.create([
  { min_salary: 0.0, max_salary: 1412.0, rate: 7.5 },
  { min_salary: 1412.01, max_salary: 2666.68, rate: 9.0 },
  { min_salary: 2666.69, max_salary: 4000.03, rate: 12.0 },
  { min_salary: 4000.04, max_salary: 7786.02, rate: 14.0 }
])

10.times do
  applicant = Applicant.create!(
    name: Faker::Name.name,
    document: Faker::IdNumber.unique.brazilian_citizen_number,
    birth_date: Faker::Date.birthday(min_age: 18, max_age: 65),
    salary: Faker::Number.decimal(l_digits: 4, r_digits: 2),
    inss_discount: 0.0
  )

  applicant.addresses.create!(
    address: Faker::Address.street_name,
    number: Faker::Address.building_number,
    neighborhood: Faker::Address.community,
    city: Faker::Address.city,
    state: Faker::Address.state_abbr,
    zip_code: Faker::Address.zip_code
  )

  rand(1..5).times do
    applicant.contacts.create!(
      contact_type: Contact.contact_types.keys.sample,
      value: Faker::PhoneNumber.phone_number
    )
  end
end
