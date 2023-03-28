class Order < ApplicationRecord
  belongs_to :employee
  belongs_to :reward
  validate :check_price
  enum status:[:non_delivered, :delivered ]
  def check_price
    errors.add :base, 'You do not have enough points' if employee.number_of_earned_points < reward.price
  end
end

