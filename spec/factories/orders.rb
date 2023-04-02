FactoryBot.define do
  factory :order do
    employee
    reward
    price { 9 }
    status { 0 }
  end
end
