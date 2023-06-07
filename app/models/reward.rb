class Reward < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 1 }
  has_many :orders, dependent: :destroy, inverse_of: :reward
  belongs_to :category
end
