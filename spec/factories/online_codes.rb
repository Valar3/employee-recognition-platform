FactoryBot.define do
  factory :online_code do
    code { SecureRandom.alphanumeric(6) }
    used { false }
    reward
  end
end
