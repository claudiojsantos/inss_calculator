FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.unique.email }
    password { '12345678' }
    password_digest { BCrypt::Password.create('12345678') }
    sign_in_count { 0 }
    current_sign_in_at { Time.current }
    last_sign_in_at { Time.current - 1.day }
  end
end
