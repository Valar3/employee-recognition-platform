FactoryBot.define do
  factory :reward do
    title { Faker::Games::Fallout.location }
    description { Faker::Games::Witcher.quote }
    price { rand(1..100) }
    category
    delivery_method { 1 }
    available_rewards { 10 }
    trait :online_code do
      delivery_method { 'online' }
      after(:create) do |reward|
        create_list(:online_code, 1, reward:)
      end
    end
  end
end
