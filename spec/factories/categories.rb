FactoryBot.define do
  factory :category do
    title { Faker::Adjective.positive }
    category_id { 1 }
  end
end
