FactoryBot.define do
  factory :kudo do
    title { 'my first factory kudo' }
    content { 'this is my first kudo created by a factory' }
    giver factory: :employee
    receiver factory: :employee
    company_value factory: :company_value
  end
end
