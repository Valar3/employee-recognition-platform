class Reward < ApplicationRecord
  validates :title, presence: true, on: :create
  validates :description, presence: true, on: :create
  validates :price, presence: true, on: :create
  validates :price, numericality: { greater_than_or_equal_to: 1 }
  validates :image, content_type: ['image/png', 'image/jpeg']
  has_many :orders, dependent: :destroy, inverse_of: :reward
  belongs_to :category
  has_one_attached :image
  enum delivery_method: { online: 0, post_delivery: 1 }

  def post_delivery?
    delivery_method == 'post_delivery'
  end
end
