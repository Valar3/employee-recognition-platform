FactoryBot.define do
  factory :reward do
    title { Faker::Games::Fallout.location }
    description { Faker::Games::Witcher.quote }
    price { rand(1..999) }
  end
end
