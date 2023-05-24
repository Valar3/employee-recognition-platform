class Reward < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 1 }
  has_many :reward_categories
  has_many :catergories, through: :reward_categories

end
