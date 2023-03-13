FactoryBot.define do
  factory :employee do
    email { Faker::Internet.email }
    password { 'password' }
    number_of_available_kudos { 10 }
    number_of_earned_points { 100.to_f }
  end
end
