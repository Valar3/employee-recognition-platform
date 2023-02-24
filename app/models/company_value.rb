class CompanyValue < ApplicationRecord
  validates :title, presence: true
  validates :title, uniqueness: { on: :create, message: 'has already been taken' }
  validates :title, uniqueness: { on: :create, message: 'has already been taken' }
end
