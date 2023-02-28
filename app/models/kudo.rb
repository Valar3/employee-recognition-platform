class Kudo < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  belongs_to :giver, class_name: 'Employee'
  belongs_to :receiver, class_name: 'Employee'
end
