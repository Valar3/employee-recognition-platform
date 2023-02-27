class Kudo < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  belongs_to :giver, class_name: 'Employee' # , dependent: :kudo
  belongs_to :receiver, class_name: 'Employee'
  has_many :company_values, class_name: "CompanyValue", foreign_key: "company_vaule_id"
end
