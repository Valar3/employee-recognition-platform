class RewardCategory < ApplicationRecord
  belongs_to :rewards
  belongs_to :categories
  
end
