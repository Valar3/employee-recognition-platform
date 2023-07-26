class Address < ApplicationRecord
  belongs_to :employee
  validates :street, presence: true
  validates :postcode, presence: true
  validates :city, presence: true

  def full_address
    "#{street}, #{postcode} #{city}"
  end
end
