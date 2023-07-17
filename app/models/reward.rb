class Reward < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 1 }
  validates :image, content_type: ['image/png', 'image/jpeg']
  has_many :orders, dependent: :destroy, inverse_of: :reward
  belongs_to :category
  has_one_attached :image

  enum delivery_method: { online: 0, post_delivery: 1 }

  validates :delivery_method, inclusion: { in: delivery_methods.keys }

  with_options if: :post_delivery? do
    validates :street, presence: true
    validates :postcode, presence: true
    validates :city, presence: true
  end

  def post_delivery?
    delivery_method == 'post_delivery'
  end       
end
