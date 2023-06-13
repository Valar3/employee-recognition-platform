class Category < ApplicationRecord
  has_many :rewards, dependent: :restrict_with_error
end
