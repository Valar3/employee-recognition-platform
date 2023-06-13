FactoryBot.define do
  factory :category do
    title { Faker::Adjective.positive }
  end
end
