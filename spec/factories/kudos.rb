FactoryBot.define do
  factory :kudo do
    title { 'my first factory kudo' }
    content { 'this is my first kudo created by a factory' }
    giver factory: :employee
    receiver factory: :employee
    company_value_id { Faker::Adjective.positive }
  end
end
