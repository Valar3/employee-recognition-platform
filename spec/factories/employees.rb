FactoryBot.define do
  factory :employee do
    name { Faker::Name.first_name }
    surname { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { 'password' }
    number_of_available_kudos { 10 }
    number_of_earned_points { 100 }
    city { Faker::Address.city }
    street { Faker::Address.street_name }
    postcode { Faker::Address.postcode }
  end
end
