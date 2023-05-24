class Category < ApplicationRecord
  has_many :reward_categories
  has_many :rewards, through: :reward_categories
  accepts_nested_attributes_for :rewards    
end
