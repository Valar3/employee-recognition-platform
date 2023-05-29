class Reward < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 1 }
  has_many :orders, dependent: :destroy, inverse_of: :reward
  has_many :reward_categories, dependent: :destroy
  has_many :categories, through: :reward_categories
  accepts_nested_attributes_for :categories
end
