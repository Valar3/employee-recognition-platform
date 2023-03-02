class Reward < ApplicationRecord
  validates :price, presence: true
  validates :price, numericality: { greater_than: 1 }
end
