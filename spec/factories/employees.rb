FactoryBot.define do
  factory :employee do
    email { Faker::Internet.email }
    password { 'password' }
  end
end
