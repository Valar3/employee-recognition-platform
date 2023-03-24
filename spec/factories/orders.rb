FactoryBot.define do
  factory :order do
    employee_id factory: :employee
    reward_id factory: :reward
    price { rand(1..10) }
   end
end
