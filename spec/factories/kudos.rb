FactoryBot.define do
  factory :kudo do
     title {'my first factory kudo'}
     content {'this is my first kudo created by a factory'}
     giver_id {current_employee_id}
     receiver_id { '1' }
  end
end
