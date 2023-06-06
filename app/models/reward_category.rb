class RewardCategory < ApplicationRecord
  belongs_to :reward
  belongs_to :category
end
