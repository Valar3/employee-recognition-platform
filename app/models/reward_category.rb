class RewardCategory < ApplicationRecord
  belongs_to :rewards
  belongs_to :categories
  accepts_nested_attributes_for :rewards
  accepts_nested_attributes_for :categories
end
