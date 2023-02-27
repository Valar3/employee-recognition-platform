class CompanyValue < ApplicationRecord
  validates :title, presence: true
  validates :title, uniqueness: { on: :create, message: 'has already been taken' }
  validates :title, uniqueness: { on: :update, message: 'has already been taken' }
  belongs_to :kudo
end
