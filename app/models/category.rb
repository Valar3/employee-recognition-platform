class Category < ApplicationRecord
  has_many :reward_categories
  has_many :rewards, through: :reward_categories
end
