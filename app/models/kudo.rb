class Kudo < ApplicationRecord
  validates :Title, presence: true
  validates :Content, presence: true
  belongs_to :giver, class_name: 'Employee'#, dependent: :kudo
  belongs_to :receiver, class_name: 'Employee'
end
